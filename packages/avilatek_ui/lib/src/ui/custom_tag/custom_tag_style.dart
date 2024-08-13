import 'dart:ui';

import 'package:avilatek_ui/src/widgets/custom_tags.dart';
import 'package:flutter/material.dart';

/// The theme data for the [CustomTag] widget.
class CustomTagStyle extends ThemeExtension<CustomTagStyle> {
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

  @override
  ThemeExtension<CustomTagStyle> copyWith({
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

  @override
  ThemeExtension<CustomTagStyle> lerp(
    covariant ThemeExtension<CustomTagStyle>? other,
    double t,
  ) {
    if (other is! CustomTagStyle) {
      return this;
    }

    return CustomTagStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      border: BoxBorder.lerp(border, other.border, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }
}
