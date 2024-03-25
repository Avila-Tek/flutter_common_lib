import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';

///  The theme data for the [CustomTag] widget.
class CustomTagTheme extends ThemeExtension<CustomTagTheme> {
  /// Creates a [CustomTagTheme].
  const CustomTagTheme({
    this.defaultStyle,
    this.primaryStyle,
    this.greenStyle,
    this.yellowStyle,
    this.redStyle,
    this.neutralStyle,
  });

  /// The default style for the [CustomTag] widget.
  final CustomTagStyle? defaultStyle;

  /// The primary style for the [CustomTag] widget.
  final CustomTagStyle? primaryStyle;

  /// The green style for the [CustomTag] widget.
  /// Usually used for success indicators.
  final CustomTagStyle? greenStyle;

  /// The yellow style for the [CustomTag] widget.
  /// Usually used for warning indicators.
  final CustomTagStyle? yellowStyle;

  /// The red style for the [CustomTag] widget.
  /// Usually used for error indicators.
  final CustomTagStyle? redStyle;

  /// The neutral style for the [CustomTag] widget.
  /// Usually used for neutral indicators.
  final CustomTagStyle? neutralStyle;

  @override
  CustomTagTheme copyWith({
    CustomTagStyle? defaultStyle,
    CustomTagStyle? primaryStyle,
    CustomTagStyle? greenStyle,
    CustomTagStyle? yellowStyle,
    CustomTagStyle? redStyle,
    CustomTagStyle? neutralStyle,
  }) {
    return CustomTagTheme(
      defaultStyle: defaultStyle ?? this.defaultStyle,
      primaryStyle: primaryStyle ?? this.primaryStyle,
      greenStyle: greenStyle ?? this.greenStyle,
      yellowStyle: yellowStyle ?? this.yellowStyle,
      redStyle: redStyle ?? this.redStyle,
      neutralStyle: neutralStyle ?? this.neutralStyle,
    );
  }

  @override
  ThemeExtension<CustomTagTheme> lerp(
    covariant ThemeExtension<CustomTagTheme>? other,
    double t,
  ) {
    if (other is! CustomTagTheme) {
      return this;
    }

    return CustomTagTheme(
      defaultStyle: CustomTagStyle.lerp(defaultStyle, other.defaultStyle, t),
      primaryStyle: CustomTagStyle.lerp(primaryStyle, other.primaryStyle, t),
      greenStyle: CustomTagStyle.lerp(greenStyle, other.greenStyle, t),
      yellowStyle: CustomTagStyle.lerp(yellowStyle, other.yellowStyle, t),
      redStyle: CustomTagStyle.lerp(redStyle, other.redStyle, t),
      neutralStyle: CustomTagStyle.lerp(neutralStyle, other.neutralStyle, t),
    );
  }
}
