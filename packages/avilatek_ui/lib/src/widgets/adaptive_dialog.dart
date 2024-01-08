// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// {@template adaptive_dialog}
/// Adaptive alert dialog that shows a CupertinoAlertDialog on iOS and an
/// AlertDialog on the other platforms.
/// {@endtemplate}
class AdaptiveAlertDialog extends StatelessWidget {
  /// {@macro adaptive_dialog}
  const AdaptiveAlertDialog({
    required this.actions,
    this.title,
    this.content,
    super.key,
  });

  final List<AdaptiveDialogAction> actions;

  final Widget? title;

  final Widget? content;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions
            .map(
              (action) => CupertinoDialogAction(
                onPressed: () {
                  action.onPressed?.call();
                  Navigator.of(context).pop();
                },
                isDefaultAction: action.isPrimaryAction,
                child: action.child,
              ),
            )
            .toList(),
      );
    }

    return AlertDialog(
      title: title,
      content: content,
      actions: actions
          .map(
            (action) => TextButton(
              child: action.child,
              onPressed: () {
                action.onPressed?.call();
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }
}

/// {@template adaptive_dialog_action}
/// Action for the [AdaptiveAlertDialog].
///
/// [child] is the action's widget.
///
/// [onPressed] is the action's callback.
/// {@endtemplate}
class AdaptiveDialogAction {
  /// {@macro adaptive_dialog_action}
  const AdaptiveDialogAction({
    required this.child,
    this.onPressed,
    this.isPrimaryAction = false,
  });

  final Widget child;

  /// Do not call [Navigator.of(context).pop()] in [onPressed]. It will be
  /// called automatically.
  final void Function()? onPressed;

  /// Whether this action is the default action of the dialog. Only have effect
  /// on iOS.
  final bool isPrimaryAction;
}
