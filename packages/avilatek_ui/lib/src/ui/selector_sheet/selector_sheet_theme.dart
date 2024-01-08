// ignore_for_file: omit_local_variable_types

import 'package:avilatek_ui/src/ui/avila_theme.dart';
import 'package:avilatek_ui/src/ui/avila_theme_data.dart';
import 'package:avilatek_ui/src/widgets/selector_sheet.dart';
import 'package:flutter/material.dart';

@immutable
class SelectorSheetThemeData {
  /// Creates a [SelectorSheetThemeData].
  const SelectorSheetThemeData({
    this.padding,
  });

  /// Defines the default padding of the [SelectorSheet] widget.
  final EdgeInsets? padding;

  /// Linearly interpolate between selector sheet button themes.
  static SelectorSheetThemeData? lerp(
    SelectorSheetThemeData? a,
    SelectorSheetThemeData? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    return SelectorSheetThemeData(
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
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
    return other is SelectorSheetThemeData && other.padding == padding;
  }
}

@immutable
class SelectorSheetItemThemeData {
  /// Creates a [SelectorSheetItemThemeData].
  const SelectorSheetItemThemeData({
    this.padding,
  });

  /// Defines the default padding of the [SelectorSheetItem] widget.
  final EdgeInsets? padding;

  /// Linearly interpolate between selector sheet button themes.
  static SelectorSheetItemThemeData? lerp(
    SelectorSheetItemThemeData? a,
    SelectorSheetItemThemeData? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    return SelectorSheetItemThemeData(
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
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
    return other is SelectorSheetItemThemeData && other.padding == padding;
  }
}

class SelectorSheetTheme extends InheritedTheme {
  /// Create a [SelectorSheetTheme].
  const SelectorSheetTheme({
    required this.selectorSheetThemeData,
    required this.selectorSheetItemThemeData,
    required super.child,
    super.key,
  });

  /// The configuration of this theme.
  final SelectorSheetThemeData selectorSheetThemeData;

  /// The configuration of this theme.
  final SelectorSheetItemThemeData selectorSheetItemThemeData;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [SelectorSheetTheme] widget, then
  /// [AvilaThemeData.selectorSheetTheme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// SelectorSheetThemeData theme = SelectorSheetTheme.of(context);
  /// ```
  static SelectorSheetThemeData of(BuildContext context) {
    final SelectorSheetTheme? theme =
        context.dependOnInheritedWidgetOfExactType<SelectorSheetTheme>();

    return theme?.selectorSheetThemeData ??
        AvilaTheme.of(context).selectorSheetTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return SelectorSheetTheme(
      selectorSheetThemeData: selectorSheetThemeData,
      selectorSheetItemThemeData: selectorSheetItemThemeData,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(SelectorSheetTheme oldWidget) =>
      selectorSheetThemeData != oldWidget.selectorSheetThemeData;
}
