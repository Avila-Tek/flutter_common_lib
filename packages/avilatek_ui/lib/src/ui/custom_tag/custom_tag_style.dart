// ignore_for_file: prefer_constructors_over_static_methods

import 'dart:ui';

import 'package:avilatek_ui/src/widgets/custom_tags.dart';
import 'package:flutter/material.dart';

/// CustomTagStyle for the [CustomTag] widget.
class CustomTagStyle {
  /// Creates a [CustomTagStyle].
  const CustomTagStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.border,
    this.padding,
    this.iconColor,
    this.iconSize,
    this.textStyle,
  });

  /// The [backgroundColor] parameter is the background color of the tag.
  final Color? backgroundColor;

  /// The [foregroundColor] parameter changes the color of the child widget.
  final Color? foregroundColor;

  /// The [border] parameter is the border of the tag. It defaults to `null`.
  final BoxBorder? border;

  /// The optional [padding] parameter overrides the default padding
  /// for [CustomTag].
  final EdgeInsets? padding;

  /// The [iconColor] parameter changes the color of the [Icon] widget.
  final Color? iconColor;

  /// The [iconSize] parameter changes the size of the [Icon] widget.
  final double? iconSize;

  /// The [textStyle] parameter changes the TextStyle of the widget.
  final TextStyle? textStyle;

  /// Creates a copy of this [CustomTagStyle] but with the given fields
  CustomTagStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    BoxBorder? border,
    EdgeInsets? padding,
    Color? iconColor,
    double? iconSize,
  }) {
    return CustomTagStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      border: border ?? this.border,
      padding: padding ?? this.padding,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  /// Linearly interpolate between two [CustomTagStyle].
  static CustomTagStyle lerp(
    CustomTagStyle? a,
    CustomTagStyle? b,
    double t,
  ) {
    if (identical(a, b) && a != null) {
      return a;
    }

    return CustomTagStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      border: BoxBorder.lerp(a?.border, b?.border, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }
}
