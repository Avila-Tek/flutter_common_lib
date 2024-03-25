import 'dart:ui';

import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';

/// The theme data for the [TitleWrapper] widget.
///
/// This class is used by [TitleWrapper] to configure the default
/// appearance of the widget.
class TitleWrapperStyle extends ThemeExtension<TitleWrapperStyle> {
  /// Creates a [TitleWrapperStyle].
  const TitleWrapperStyle({
    this.titleSpacing,
    this.footerSpacing,
    this.titleStyle,
    this.footerStyle,
  });

  /// Defines the default space between title and child of the
  // / [TitleWrapper] widget.
  final double? titleSpacing;

  /// Defines the default spacing between child and footer of the
  /// [TitleWrapper] widget.
  final double? footerSpacing;

  /// Defines the default title TextStyle of the [TitleWrapper] widget.
  final TextStyle? titleStyle;

  /// Defines the default footer TextStyle of the [TitleWrapper] widget.
  final TextStyle? footerStyle;

  @override
  ThemeExtension<TitleWrapperStyle> copyWith({
    double? titleSpacing,
    double? footerSpacing,
    TextStyle? titleStyle,
    TextStyle? footerStyle,
  }) =>
      TitleWrapperStyle(
        titleSpacing: titleSpacing ?? this.titleSpacing,
        footerSpacing: footerSpacing ?? this.footerSpacing,
        titleStyle: titleStyle ?? this.titleStyle,
        footerStyle: footerStyle ?? this.footerStyle,
      );

  @override
  ThemeExtension<TitleWrapperStyle> lerp(
    covariant ThemeExtension<TitleWrapperStyle>? other,
    double t,
  ) {
    if (other is! TitleWrapperStyle) {
      return this;
    }

    return TitleWrapperStyle(
      titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t),
      footerSpacing: lerpDouble(footerSpacing, other.footerSpacing, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      footerStyle: TextStyle.lerp(footerStyle, other.footerStyle, t),
    );
  }
}
