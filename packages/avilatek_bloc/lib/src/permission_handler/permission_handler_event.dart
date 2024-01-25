// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'permission_handler_bloc.dart';

abstract class PermissionHandlerEvent {
  const PermissionHandlerEvent();
}

/// Start verification event
class PermissionHandlerVerificationStarted extends PermissionHandlerEvent {
  const PermissionHandlerVerificationStarted({
    required this.permission,
  });
  final Permission permission;
}

/// This event only functions if the permission is not permanently denied.
/// If the permission is permanently denied, the user must manually grant it
/// through the device's settings.
class PermissionHandlerRequested extends PermissionHandlerEvent {}

/// This event only functions if the permission is permanently denied.
class PermissionHandlerOpenSettingsPressed extends PermissionHandlerEvent {
  const PermissionHandlerOpenSettingsPressed({
    required this.permission,
  });
  final Permission permission;
}

class _PermissionHandlerPermissionTicked extends PermissionHandlerEvent {
  const _PermissionHandlerPermissionTicked({
    required this.permission,
  });
  final Permission permission;
}
