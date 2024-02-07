// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, hash_and_equals
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// [AdaptiveDialogThemeData] defines the theme of an adaptive dialog.
@immutable
class AdaptiveDialogThemeData extends ThemeExtension<AdaptiveDialogThemeData> {
  /// Creates an [AdaptiveDialogThemeData].
  const AdaptiveDialogThemeData({
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

  /// Linearly interpolate between two AdaptiveDialogThemeData.
  static AdaptiveDialogThemeData? lerpThemeData(
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
      contentTextStyle: TextStyle.lerp(
        a?.contentTextStyle,
        b?.contentTextStyle,
        t,
      ),
      actionTextStyle: TextStyle.lerp(a?.actionTextStyle, b?.actionTextStyle, t),
    );
  }

  /// Creates a copy of this theme but with the given fields replaced with the new values.
  @override
  AdaptiveDialogThemeData copyWith({
    Color? backgroundColor,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? actionTextStyle,
  }) {
    return AdaptiveDialogThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
    );
  }

  @override
  ThemeExtension<AdaptiveDialogThemeData> lerp(covariant ThemeExtension<AdaptiveDialogThemeData>? other, double t) {
    return AdaptiveDialogThemeData.lerpThemeData(this, other as AdaptiveDialogThemeData?, t)!;
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
    return other is AdaptiveDialogThemeData &&
        other.backgroundColor == backgroundColor &&
        other.titleTextStyle == titleTextStyle &&
        other.contentTextStyle == contentTextStyle &&
        other.actionTextStyle == actionTextStyle;
  }
}
