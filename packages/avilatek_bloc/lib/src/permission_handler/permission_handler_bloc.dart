import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_handler_event.dart';
part 'permission_handler_state.dart';

/// Bloc to handle permission management
class PermissionHandlerBloc
    extends Bloc<PermissionHandlerEvent, PermissionHandlerState> {
  /// Constructor for the PermissionHandlerBloc.
  ///
  /// * [permissionsToValidate]: The list of permissions to be validated.
  PermissionHandlerBloc({
    required List<Permission> permissionsToValidate,
  })  : _permissionsToValidate = permissionsToValidate,
        super(
          PermissionHandlerState(
            permissionsToValidate: permissionsToValidate,
          ),
        ) {
    // Registers an event handler for the PermissionHandlerVerificationStarted.
    on<PermissionHandlerVerificationStarted>(
      _onVerificationStarted,
      transformer: sequential(), // Ensures events are processed sequentially.
    );
    on<PermissionHandlerRequested>(_onRequestPermission);
    on<_PermissionHandlerPermissionTicked>(_permissionStatusTicked);
    on<PermissionHandlerOpenSettingsPressed>(_onOpenSettingsPressed);

    _startBatchVerification();
  }

  /// Initiates verification for a batch of permissions.
  void _startBatchVerification() {
    // Iterates through each permission in the list and initiates verification.
    for (final permission in _permissionsToValidate) {
      // Adds a PermissionHandlerVerificationStarted event for the permission.
      // This triggers the verification process for each permission sequentially
      add(PermissionHandlerVerificationStarted(permission: permission));
    }
  }

  // Private list of permissions to be validated.
  final List<Permission> _permissionsToValidate;
  StreamSubscription<void>? _permissionSettingsSubscription;

  /// Handles the PermissionHandlerVerificationStarted event.
  FutureOr<void> _onVerificationStarted(
    PermissionHandlerVerificationStarted event,
    Emitter<PermissionHandlerState> emit,
  ) async {
    /// Finish if the current permission is denied or permantly denied
    if (state.permissionIsDeniedOrPermantlyDenied) return;

    // Retrieves the permission to verify from the event.
    final permissionToVerify = event.permission;

    // Fetches the current status of the permission.
    final permissionStatus = await permissionToVerify.status;

    // Emits a new state with the updated information.
    emit(
      PermissionHandlerState(
        permissionsToValidate: _permissionsToValidate,
        permission: permissionToVerify,
        permissionStatus: permissionStatus,
      ),
    );
  }

  /// Request permission for the current permission.
  ///
  /// Note: This event only functions if the permission
  /// is not permanently denied.
  /// If the permission is permanently denied, the user must manually grant it
  /// through the device's settings.
  Future<void> _onRequestPermission(
    PermissionHandlerRequested event,
    Emitter<PermissionHandlerState> emit,
  ) async {
    final currentPermission = state.permission;

    if (currentPermission == null) return;

    // Attempt to request the permission.
    final permissionStatus = await currentPermission.request();

    // Emits a new state with the updated information, indicating whether
    // the request was successful or if the user needs to manually grant
    // permission in settings.
    emit(
      PermissionHandlerState(
        permissionsToValidate: _permissionsToValidate,
        permission: currentPermission,
        permissionStatus: permissionStatus,
      ),
    );

    /// Continue with next permissions
    _startBatchVerification();
  }

  Future<void> _onOpenSettingsPressed(
    PermissionHandlerOpenSettingsPressed event,
    Emitter<PermissionHandlerState> emit,
  ) async {
    await openAppSettings();
    await _permissionSettingsSubscription?.cancel();
    _permissionSettingsSubscription =
        Stream<void>.periodic(const Duration(seconds: 1)).listen((_) {
      add(_PermissionHandlerPermissionTicked(permission: event.permission));
    });
  }

  Future<void> _permissionStatusTicked(
    _PermissionHandlerPermissionTicked event,
    Emitter<PermissionHandlerState> emit,
  ) async {
    // Fetches the current status of the permission.
    final permissionStatus = await event.permission.status;
    if (permissionStatus.isGranted) {
      await _permissionSettingsSubscription?.cancel();
      _startBatchVerification();
    }
  }

  @override
  Future<void> close() async {
    await _permissionSettingsSubscription?.cancel();
    return super.close();
  }
}
