import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [AdaptiveDialogActionStyle] defines the style of an adaptive dialog action.
class AdaptiveDialogActionStyle {
  const AdaptiveDialogActionStyle({
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  /// The color of the text for the action.
  final Color? textColor;

  /// The size of the font for the action.
  final double? fontSize;

  /// The weight of the font for the action.
  final FontWeight? fontWeight;
}

/// [AdaptiveDialogAction] defines an action for an adaptive dialog.
class AdaptiveDialogAction {
  const AdaptiveDialogAction({
    required this.child,
    this.onPressed,
    this.isPrimaryAction = false,
    this.style,
  });

  /// The widget to display for the action.
  final Widget child;

  /// The function to call when the action is pressed.
  final void Function()? onPressed;

  /// Whether this action is the primary action for the dialog.
  final bool isPrimaryAction;

  /// The style to use for this action.
  final AdaptiveDialogActionStyle? style;
}

/// [AdaptiveAlertDialog] is a dialog that adapts to the platform.
class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog({
    required this.actions,
    this.title,
    this.content,
    this.style,
    this.backgroundColor,
    super.key,
  });

  /// The actions for the dialog.
  final List<AdaptiveDialogAction> actions;

  /// The title widget for the dialog.
  final Widget? title;

  /// The content widget for the dialog.
  final Widget? content;

  /// The style to use for the dialog.
  final AdaptiveDialogActionStyle? style;

  /// The background color for the dialog.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    // Use CupertinoAlertDialog for iOS
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

    // Use AlertDialog for other platforms
    return AlertDialog(
      title: title,
      content: content,
      backgroundColor:
          backgroundColor ?? Theme.of(context).dialogBackgroundColor,
      actions: actions
          .map(
            (action) => TextButton(
              onPressed: () {
                action.onPressed?.call();
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  style?.textColor ?? action.style?.textColor,
                ),
              ),
              child: action.child,
            ),
          )
          .toList(),
    );
  }
}

/// [AdaptiveInputDialog] is an input dialog that adapts to the platform.
class AdaptiveInputDialog extends StatelessWidget {
  const AdaptiveInputDialog({
    required this.title,
    required this.actions,
    required this.controller,
    this.placeholder = '',
    super.key,
    this.style,
  });

  /// The title widget for the dialog.
  final Widget title;

  /// The placeholder text for the input field.
  final String placeholder;

  /// The actions for the dialog.
  final List<AdaptiveDialogAction> actions;

  /// The controller for the input field.
  final TextEditingController controller;

  /// The style to use for the dialog.
  final AdaptiveDialogActionStyle? style;

  @override
  Widget build(BuildContext context) {
    // Use CupertinoAlertDialog for Android
    if (Platform.isAndroid) {
      return CupertinoAlertDialog(
        title: title,
        content: CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
        ),
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
    } else {
      // Use AlertDialog for other platforms
      return AlertDialog(
        title: title,
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: placeholder),
        ),
        actions: actions
            .map(
              (action) => TextButton(
                onPressed: () {
                  action.onPressed?.call();
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    style?.textColor ?? action.style?.textColor,
                  ),
                ),
                child: action.child,
              ),
            )
            .toList(),
      );
    }
  }
}
