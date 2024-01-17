import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';

class MockPermission extends Mock implements Permission {
  @override
  int get value => 0;
}

void main() {
  final mockPermission = MockPermission();
  group('PermissionHandlerBloc', () {
    blocTest<PermissionHandlerBloc, PermissionHandlerState>(
      'emits initial state with permissions to validate',
      build: () => PermissionHandlerBloc(
        permissionsToValidate: [MockPermission(), MockPermission()],
      ),
      expect: () => [
        PermissionHandlerState(
          permissionsToValidate: [MockPermission(), MockPermission()],
        ),
      ],
    );

    blocTest<PermissionHandlerBloc, PermissionHandlerState>(
      'emits state with permission and status when verification started',
      build: () {
        final mockPermission = MockPermission();
        when(() => mockPermission.status)
            .thenAnswer((_) async => PermissionStatus.granted);
        return PermissionHandlerBloc(
          permissionsToValidate: [mockPermission],
        );
      },
      act: (bloc) => bloc.add(
        PermissionHandlerVerificationStarted(permission: mockPermission),
      ),
      expect: () => [
        PermissionHandlerState(
          permissionsToValidate: [mockPermission],
          permission: mockPermission,
          permissionStatus: PermissionStatus.granted,
        ),
      ],
    );

    blocTest<PermissionHandlerBloc, PermissionHandlerState>(
      'emits state with updated status when permission requested',
      build: () {
        final mockPermission = MockPermission();
        when(mockPermission.request)
            .thenAnswer((_) async => PermissionStatus.denied);
        return PermissionHandlerBloc(
          permissionsToValidate: [mockPermission],
        );
      },
      seed: () => PermissionHandlerState(
        permissionsToValidate: [mockPermission],
        permission: mockPermission,
        permissionStatus: PermissionStatus.denied,
      ),
      act: (bloc) => bloc.add(PermissionHandlerRequested()),
      expect: () => [
        PermissionHandlerState(
          permissionsToValidate: [mockPermission],
          permission: mockPermission,
          permissionStatus: PermissionStatus.denied,
        ),
      ],
    );
  });
}
