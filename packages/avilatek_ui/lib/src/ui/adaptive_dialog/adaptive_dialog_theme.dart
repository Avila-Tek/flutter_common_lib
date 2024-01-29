// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, hash_and_equals

import 'package:flutter/material.dart';

@immutable
class AdaptiveDialogThemeData {
  const AdaptiveDialogThemeData({
    this.backgroundColor,
    this.titleTextStyle,
    this.contentTextStyle,
    this.actionTextStyle,
  });

  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final TextStyle? actionTextStyle;

  static AdaptiveDialogThemeData? lerp(
    AdaptiveDialogThemeData? a,
    AdaptiveDialogThemeData? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }

    return AdaptiveDialogThemeData(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      contentTextStyle: TextStyle.lerp(a?.contentTextStyle, b?.contentTextStyle, t),
      actionTextStyle: TextStyle.lerp(a?.actionTextStyle, b?.actionTextStyle, t),
    );
  }

  @override
  int get hashCode => backgroundColor.hashCode;
}
