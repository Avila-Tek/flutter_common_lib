import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:avilatek_bloc/avilatek_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerExamplePage extends StatelessWidget {
  const PermissionHandlerExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PermissionHandlerBloc(
        permissionsToValidate: [Permission.camera],
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Permission Handler Bloc Example'),
        ),
        body: const PermissionHandlerExampleView(),
      ),
    );
  }
}

class PermissionHandlerExampleView extends StatelessWidget {
  const PermissionHandlerExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return PermissionHandlerListener(
      onDenied: (context, permission, permissionStatus) {
        showDialog(
          context: context,
          builder: (context2) {
            return SimpleDialog(
              title: Text('$permission requested denied!'),
              children: [
                Text('We require $permission for...'),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<PermissionHandlerBloc>()
                        .add(PermissionHandlerRequested());
                    Navigator.pop(context2);
                  },
                  child: const Text('Allow'),
                )
              ],
            );
          },
        );
      },
      onPermanentlyDenied: (context, permission, permissionStatus) {
        showDialog(
          context: context,
          builder: (context2) {
            return SimpleDialog(
              title: Text('$permission is permanently denied!'),
              children: [
                Text('Open settings for $permission...'),
                ElevatedButton(
                  onPressed: () async {
                    context.read<PermissionHandlerBloc>().add(
                        PermissionHandlerOpenSettingsPressed(
                            permission: permission));

                    Navigator.pop(context2);
                  },
                  child: const Text('Open settings'),
                )
              ],
            );
          },
        );
      },
      onGranted: (context, permission, permissionStatus) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$permission is granted')),
        );
      },
      child: const Center(child: Placeholder()),
    );
  }
}
