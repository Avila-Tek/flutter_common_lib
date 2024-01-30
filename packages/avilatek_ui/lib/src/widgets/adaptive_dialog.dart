// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDialogActionStyle {
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const AdaptiveDialogActionStyle({
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });
}

class AdaptiveDialogAction {
  const AdaptiveDialogAction({
    required this.child,
    this.onPressed,
    this.isPrimaryAction = false,
    this.style,
  });

  final Widget child;
  final void Function()? onPressed;
  final bool isPrimaryAction;
  final AdaptiveDialogActionStyle? style;
}

class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog({
    required this.actions,
    this.title,
    this.content,
    this.style,
    super.key,
  });

  final List<AdaptiveDialogAction> actions;
  final Widget? title;
  final Widget? content;
  final AdaptiveDialogActionStyle? style;

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

class AdaptiveInputDialog extends StatelessWidget {
  const AdaptiveInputDialog({
    required this.title,
    required this.placeholder,
    required this.actions,
    required this.controller,
    super.key,
    this.style,
  });

  final Widget title;
  final String placeholder;
  final List<AdaptiveDialogAction> actions;
  final TextEditingController controller;
  final AdaptiveDialogActionStyle? style;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
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
