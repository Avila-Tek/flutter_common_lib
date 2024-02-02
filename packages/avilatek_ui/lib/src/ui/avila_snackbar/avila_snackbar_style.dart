import 'dart:ui';

import 'package:flutter/material.dart';

class AvilaSnackBarStyle extends ThemeExtension<AvilaSnackBarStyle> {
  const AvilaSnackBarStyle({
    this.backgroundColor,
    this.titleStyle,
    this.messageStyle,
    this.elevation,
    this.margin,
    this.padding,
  });

  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  ThemeExtension<AvilaSnackBarStyle> copyWith({
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) =>
      AvilaSnackBarStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        titleStyle: titleStyle ?? this.titleStyle,
        messageStyle: messageStyle ?? this.messageStyle,
        elevation: elevation ?? this.elevation,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
      );

  @override
  ThemeExtension<AvilaSnackBarStyle> lerp(
    covariant ThemeExtension<AvilaSnackBarStyle>? other,
    double t,
  ) {
    if (other is! AvilaSnackBarStyle) {
      return this;
    }

    return AvilaSnackBarStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      messageStyle: TextStyle.lerp(messageStyle, other.messageStyle, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
    );
  }
}
