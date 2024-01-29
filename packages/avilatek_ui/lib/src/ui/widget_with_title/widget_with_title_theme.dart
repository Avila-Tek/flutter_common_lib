// ignore_for_file: omit_local_variable_types

import 'dart:ui';

import 'package:avilatek_ui/src/ui/avila_theme.dart';
import 'package:avilatek_ui/src/ui/avila_theme_data.dart';
import 'package:avilatek_ui/src/widgets/widget_with_title.dart';
import 'package:flutter/material.dart';

/// [WidgetWithTitleThemeData] defines the theme of the [WidgetWithTitle] widget.
@immutable
class WidgetWithTitleThemeData {
  /// Creates a [WidgetWithTitleThemeData].
  const WidgetWithTitleThemeData({
    this.titleSpacing,
    this.footerSpacing,
    this.titleStyle,
    this.footerStyle,
    this.padding,
  });

  /// Defines the default space between title and child of the
  /// [WidgetWithTitle] widget.
  final double? titleSpacing;

  /// Defines the default spacing between child and footer of the
  /// [WidgetWithTitle] widget.
  final double? footerSpacing;

  /// Defines the default padding of the [WidgetWithTitle] widget.
  final EdgeInsets? padding;

  /// Defines the default title TextStyle of the [WidgetWithTitle] widget.
  final TextStyle? titleStyle;

  /// Defines the default footer TextStyle of the [WidgetWithTitle] widget.
  final TextStyle? footerStyle;

  /// Linearly interpolate between selector sheet button themes.
  static WidgetWithTitleThemeData? lerp(
    WidgetWithTitleThemeData? a,
    WidgetWithTitleThemeData? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }

    return WidgetWithTitleThemeData(
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      titleSpacing: lerpDouble(a?.titleSpacing, b?.titleSpacing, t),
      footerSpacing: lerpDouble(a?.footerSpacing, b?.footerSpacing, t),
      titleStyle: TextStyle.lerp(a?.titleStyle, b?.titleStyle, t),
      footerStyle: TextStyle.lerp(a?.footerStyle, b?.footerStyle, t),
    );
  }

  @override
  int get hashCode => padding.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is WidgetWithTitleThemeData &&
        other.padding == padding &&
        other.titleSpacing == titleSpacing &&
        other.footerSpacing == footerSpacing &&
        other.titleStyle == titleStyle &&
        other.footerStyle == footerStyle;
  }
}

class WidgetWithTitleTheme extends InheritedTheme {
  /// Create a [WidgetWithTitleTheme].
  const WidgetWithTitleTheme({
    required this.fieldWithTitleThemeData,
    required super.child,
    super.key,
  });

  /// The configuration of this theme.
  final WidgetWithTitleThemeData fieldWithTitleThemeData;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [WidgetWithTitleTheme] widget, then
  /// [AvilaThemeData.fieldWithTitleTheme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// FieldWithTitleThemeData theme = FieldWithTitleTheme.of(context);
  /// ```
  static WidgetWithTitleThemeData of(BuildContext context) {
    final WidgetWithTitleTheme? theme =
        context.dependOnInheritedWidgetOfExactType<WidgetWithTitleTheme>();

    return theme?.fieldWithTitleThemeData ??
        AvilaTheme.of(context).fieldWithTitleTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return WidgetWithTitleTheme(
      fieldWithTitleThemeData: fieldWithTitleThemeData,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(WidgetWithTitleTheme oldWidget) =>
      fieldWithTitleThemeData != oldWidget.fieldWithTitleThemeData;
}
