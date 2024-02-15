// ignore_for_file: lines_longer_than_80_chars, hash_and_equals
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// [AdaptiveAlertDialogThemeData] defines the theme of an adaptive dialog.
@immutable
class AdaptiveAlertDialogThemeData extends ThemeExtension<AdaptiveAlertDialogThemeData> {
  /// Creates an [AdaptiveAlertDialogThemeData].
  const AdaptiveAlertDialogThemeData({
    this.backgroundColor,
    this.titleTextStyle,
    this.contentTextStyle,
    this.actionTextStyle,
  });

  /// Defines the background color of the dialog.
  final Color? backgroundColor;

  /// Defines the text style of the dialog's title.
  final TextStyle? titleTextStyle;

  /// Defines the text style of the dialog's content.
  final TextStyle? contentTextStyle;

  /// Defines the text style of the dialog's actions.
  final TextStyle? actionTextStyle;

  /// Creates a copy of this theme but with the given fields replaced with the new values.
  @override
  AdaptiveAlertDialogThemeData copyWith({
    Color? backgroundColor,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? actionTextStyle,
  }) {
    return AdaptiveAlertDialogThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
    );
  }

  @override
  ThemeExtension<AdaptiveAlertDialogThemeData> lerp(
    covariant ThemeExtension<AdaptiveAlertDialogThemeData>? other,
    double t,
  ) {
    if (identical(this, other)) {
      return this;
    }

    if (other == null) {
      return this;
    }

    final otherTheme = other as AdaptiveAlertDialogThemeData;

    return AdaptiveAlertDialogThemeData(
      backgroundColor: Color.lerp(backgroundColor, otherTheme.backgroundColor, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, otherTheme.titleTextStyle, t),
      contentTextStyle: TextStyle.lerp(contentTextStyle, otherTheme.contentTextStyle, t),
      actionTextStyle: TextStyle.lerp(actionTextStyle, otherTheme.actionTextStyle, t),
    );
  }

  @override
  int get hashCode => const ListEquality<Object?>().hash([
        backgroundColor,
        titleTextStyle,
        contentTextStyle,
        actionTextStyle,
      ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AdaptiveAlertDialogThemeData &&
        other.backgroundColor == backgroundColor &&
        other.titleTextStyle == titleTextStyle &&
        other.contentTextStyle == contentTextStyle &&
        other.actionTextStyle == actionTextStyle;
  }
}
