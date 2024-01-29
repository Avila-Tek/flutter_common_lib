import 'package:avilatek_ui/src/ui/avila_theme.dart';
import 'package:avilatek_ui/src/ui/widget_with_title/widget_with_title_theme.dart';
import 'package:avilatek_ui/src/ui/selector_sheet/selector_sheet_theme.dart';
import 'package:flutter/material.dart';

/// Defines the configuration of the overall visual [AvilaTheme] for a
/// [MaterialApp] or a widget subtree within the app.
class AvilaThemeData {
  /// Create an [AvilaThemeData] that's used to configure an [AvilaTheme].
  factory AvilaThemeData({
    double gridUnitSize = 8.0,
    EdgeInsets? margins,
    SelectorSheetThemeData? selectorSheetTheme,
    WidgetWithTitleThemeData? fieldWithTitleTheme,
  }) {
    margins ??= EdgeInsets.symmetric(horizontal: gridUnitSize * 2);
    selectorSheetTheme ??= const SelectorSheetThemeData();
    fieldWithTitleTheme ??= WidgetWithTitleThemeData(
      titleSpacing: gridUnitSize * 3,
      footerSpacing: gridUnitSize * 2,
      titleStyle: ThemeData().textTheme.titleLarge?.copyWith(
            fontSize: 16,
          ),
      footerStyle: ThemeData().textTheme.bodyMedium?.copyWith(
            fontSize: 14,
          ),
      padding: EdgeInsets.symmetric(
        horizontal: gridUnitSize * 2,
        vertical: gridUnitSize,
      ),
    );

    return AvilaThemeData.raw(
      gridUnitSize: gridUnitSize,
      margins: margins,
      selectorSheetTheme: selectorSheetTheme,
      fieldWithTitleTheme: fieldWithTitleTheme,
    );
  }

  /// Create an [AvilaThemeData] given a set of exact values.
  const AvilaThemeData.raw({
    required this.gridUnitSize,
    required this.margins,
    required this.selectorSheetTheme,
    required this.fieldWithTitleTheme,
  });

  /// The default color theme.
  ///
  /// This is used by [AvilaTheme.of] when no theme has been specified.
  factory AvilaThemeData.fallback() => AvilaThemeData();

  final double gridUnitSize;

  final EdgeInsets margins;

  final SelectorSheetThemeData selectorSheetTheme;

  final WidgetWithTitleThemeData fieldWithTitleTheme;
}
