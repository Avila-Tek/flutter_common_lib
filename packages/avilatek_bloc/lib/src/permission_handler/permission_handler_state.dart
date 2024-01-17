part of 'permission_handler_bloc.dart';

class PermissionHandlerState extends Equatable {
  const PermissionHandlerState({
    required this.permissionsToValidate,
    this.permission,
    this.permissionStatus,
  });

  final List<Permission> permissionsToValidate;
  final Permission? permission;
  final PermissionStatus? permissionStatus;

  @override
  List<Object?> get props => [
        permissionsToValidate,
        permission,
        permissionStatus,
      ];

  /// Get current permission status is denied or isPermanentlyDenied
  bool get permissionIsDeniedOrPermantlyDenied {
    if (permission == null) return false;
    if (permissionStatus == null) return false;
    return permissionStatus!.isDenied || permissionStatus!.isPermanentlyDenied;
  }
}
