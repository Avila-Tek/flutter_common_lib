// ignore_for_file: omit_local_variable_types, lines_longer_than_80_chars

import 'package:avilatek_ui/src/widgets/selector_sheet.dart';
import 'package:flutter/material.dart';

/// The theme data for the [SelectorSheet] widget.
///
/// This class is used by [SelectorSheet] to configure the default
/// appearance of the widget.
class SelectorSheetTheme extends ThemeExtension<SelectorSheetTheme> {
  /// Creates a [SelectorSheetThemeData].
  const SelectorSheetTheme({
    this.selectorSheetItemThemeData,
    this.selectorSheetThemeData,
  });

  /// The default [SelectorSheetItemThemeData] for the [SelectorSheetItem] widget.
  final SelectorSheetItemThemeData? selectorSheetItemThemeData;

  /// The default [SelectorSheetThemeData] for the [SelectorSheet] widget.
  final SelectorSheetThemeData? selectorSheetThemeData;

  @override
  ThemeExtension<SelectorSheetTheme> lerp(
    covariant ThemeExtension<SelectorSheetTheme>? other,
    double t,
  ) {
    if (other is! SelectorSheetTheme) {
      return this;
    }

    return const SelectorSheetTheme();
  }

  /// Creates a copy of this theme but with the given fields replaced with the
  /// new values.
  ///
  /// If the new value is null, the value from the original theme will be used.
  ///
  /// If the original theme is null, the new value will be used.
  ///
  ///  **Returns**
  ///
  /// A new [SelectorSheetTheme] with the values updated.
  @override
  ThemeExtension<SelectorSheetTheme> copyWith({
    SelectorSheetItemThemeData? selectorSheetItemThemeData,
    SelectorSheetThemeData? selectorSheetThemeData,
  }) {
    return SelectorSheetTheme(
      selectorSheetItemThemeData:
          selectorSheetItemThemeData ?? this.selectorSheetItemThemeData,
      selectorSheetThemeData:
          selectorSheetThemeData ?? this.selectorSheetThemeData,
    );
  }
}

/// The theme data for the [SelectorSheetItem] widget.
///
/// This class is used by [SelectorSheetItem] to configure the default
/// appearance of the widget.
class SelectorSheetItemThemeData
    extends ThemeExtension<SelectorSheetItemThemeData> {
  /// Creates a [SelectorSheetItemThemeData].
  const SelectorSheetItemThemeData({
    this.padding,
    this.backgroundColor,
    this.textStyle,
    this.clipBehavior,
  });

  /// Defines the default padding of the [SelectorSheetItem] widget.
  final EdgeInsets? padding;

  /// Defines the default background color of the [SelectorSheetItem] widget.
  final Color? backgroundColor;

  /// Defines the default text style of the [SelectorSheetItem] widget.
  final TextStyle? textStyle;

  /// Defines the default clip behavior of the [SelectorSheetItem] widget.
  final Clip? clipBehavior;

  /// Linearly interpolate between two [SelectorSheetItemThemeData].
  @override
  ThemeExtension<SelectorSheetItemThemeData> lerp(
    covariant ThemeExtension<SelectorSheetItemThemeData>? other,
    double t,
  ) {
    if (other is! SelectorSheetItemThemeData) {
      return this;
    }

    return SelectorSheetItemThemeData(
      padding: EdgeInsets.lerp(padding, other.padding, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
    );
  }

  /// Creates a copy of this theme but with the given fields replaced with the
  /// new values.
  ///
  /// If the new value is null, the value from the original theme will be used.
  ///
  /// If the original theme is null, the new value will be used.
  ///
  /// **Returns**
  ///
  /// A new [SelectorSheetItemThemeData] with the values updated.
  @override
  ThemeExtension<SelectorSheetItemThemeData> copyWith({
    EdgeInsets? padding,
    Color? backgroundColor,
    TextStyle? textStyle,
    Clip? clipBehavior,
  }) {
    return SelectorSheetItemThemeData(
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }
}

/// The theme data for the [SelectorSheet] widget.
///
/// This class is used by [SelectorSheet] to configure the default
/// appearance of the widget.
class SelectorSheetThemeData extends ThemeExtension<SelectorSheetThemeData> {
  /// Create a [SelectorSheetTheme].
  const SelectorSheetThemeData({
    this.backgroundColor,
    this.padding,
  });

  /// The default background color of the [SelectorSheet] widget.
  final Color? backgroundColor;

  /// The default padding of the [SelectorSheet] widget.
  final EdgeInsets? padding;

  /// Creates a copy of this theme but with the given fields replaced with the
  /// new values.
  ///
  /// If the new value is null, the value from the original theme will be used.
  ///
  /// If the original theme is null, the new value will be used.
  ///
  /// **Returns**
  ///
  /// A new [SelectorSheetThemeData] with the values updated.
  @override
  ThemeExtension<SelectorSheetThemeData> copyWith({
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return SelectorSheetThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
    );
  }

  /// Linearly interpolate between two [SelectorSheetThemeData].
  @override
  ThemeExtension<SelectorSheetThemeData> lerp(
    covariant ThemeExtension<SelectorSheetThemeData>? other,
    double t,
  ) {
    if (other is! SelectorSheetThemeData) {
      return this;
    }

    return SelectorSheetThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
    );
  }
}
