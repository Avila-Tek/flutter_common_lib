// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class SelectorButtonStyle extends ThemeExtension<SelectorButtonStyle> {
  const SelectorButtonStyle({
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.defaultRadius,
    this.padding,
    this.loadingTextStyle,
    this.loadingIconSize,
    this.borderSideWidth,
    this.titleMaxLines,
  });

  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final double? padding;
  final TextStyle? loadingTextStyle;
  final double? defaultRadius;
  final double? loadingIconSize;
  final double? borderSideWidth;
  final int? titleMaxLines;

  @override
  ThemeExtension<SelectorButtonStyle> lerp(
    covariant ThemeExtension<SelectorButtonStyle>? other,
    double t,
  ) {
    if (other is! SelectorButtonStyle) {
      return this;
    }

    return SelectorButtonStyle(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      padding: lerpDouble(padding, other.padding, t),
      loadingTextStyle:
          TextStyle.lerp(loadingTextStyle, other.loadingTextStyle, t),
      defaultRadius: lerpDouble(defaultRadius, other.defaultRadius, t),
      loadingIconSize: lerpDouble(loadingIconSize, other.loadingIconSize, t),
      borderSideWidth: lerpDouble(borderSideWidth, other.borderSideWidth, t),
      titleMaxLines: titleMaxLines,
      
    );
  }

  @override
  ThemeExtension<SelectorButtonStyle> copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    double? padding,
    TextStyle? loadingTextStyle,
    double? defaultRadius,
    double? loadingIconSize,
    double? borderSideWidth,
    int? titleMaxLines,
  }) {
    return SelectorButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      padding: padding ?? this.padding,
      loadingTextStyle: loadingTextStyle ?? this.loadingTextStyle,
      defaultRadius: defaultRadius ?? this.defaultRadius,
      loadingIconSize: loadingIconSize ?? this.loadingIconSize,
      borderSideWidth: borderSideWidth ?? this.borderSideWidth,
      titleMaxLines: titleMaxLines ?? this.titleMaxLines,
    );
  }
}
