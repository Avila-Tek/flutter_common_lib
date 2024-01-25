import 'package:avilatek_bloc/src/permission_handler/permission_handler_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

/// A widget that listens to permission changes from a PermissionHandlerBloc
/// and calls specified callbacks based on the permission status.
class PermissionHandlerListener extends StatelessWidget {
  /// A widget that listens to permission changes from a PermissionHandlerBloc
  /// and calls specified callbacks based on the permission status.
  const PermissionHandlerListener({
    required this.child,
    super.key,
    this.onDenied,
    this.onPermanentlyDenied,
    this.onGranted,
  });

  /// Optional callback for when a permission is denied.
  final void Function(
    BuildContext context,
    Permission permission,
    PermissionStatus permissionStatus,
  )? onDenied;

  /// Optional callback for when a permission is permanently denied.
  final void Function(
    BuildContext context,
    Permission permission,
    PermissionStatus permissionStatus,
  )? onPermanentlyDenied;

  /// Optional callback for when a permission is granted.
  final void Function(
    BuildContext context,
    Permission permission,
    PermissionStatus permissionStatus,
  )? onGranted;

  /// The child widget that will be wrapped by this listener.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionHandlerBloc, PermissionHandlerState>(
      listener: (context, state) {
        // Extract permission and status information from the state:
        final permission = state.permission;
        final permissionStatus = state.permissionStatus;

        // Ensure both permission and status are available before proceeding:
        if (permission == null || permissionStatus == null) return;

        // Call appropriate callbacks based on the permission status:
        if (permissionStatus.isDenied && onDenied != null) {
          onDenied!(context, permission, permissionStatus);
        }
        if (permissionStatus.isPermanentlyDenied &&
            onPermanentlyDenied != null) {
          onPermanentlyDenied!(context, permission, permissionStatus);
        }
        if (permissionStatus.isGranted && onGranted != null) {
          onGranted!(context, permission, permissionStatus);
        }
      },
      child: child,
    );
  }
}
