import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:flutter/material.dart';

/// [AvilaCustomTheme] class is being used to handle the theme of
/// `AvilaCustomTheme`. Here, we can handle the theme of `TitleWrapperStyle`,
/// `SelectorButtonStyle` and `AvilaSnackBarTheme`
class AvilaCustomTheme {
  /// [AvilaCustomTheme] class is being used to handle the theme of
  /// AvilaTek widgets
  const AvilaCustomTheme({
    this.titleWrapperStyle,
    this.selectorButtonStyle,
    this.avilaSnackBarTheme,
  });

  /// `titleWrapperStyle` is being used to handle the theme of
  /// [TitleWrapper] widget
  final TitleWrapperStyle? titleWrapperStyle;

  /// `selectorButtonStyle` is a is being used to handle the theme of
  /// [SelectorButton] widget
  final SelectorButtonStyle? selectorButtonStyle;

  /// `avilaSnackBarTheme` is being used to handle the theme of
  /// [AvilaSnackBar] widget
  final AvilaSnackBarTheme? avilaSnackBarTheme;

  /// `extensions` is used to get all AvilaTek theme extensions, to then
  /// define in the `MaterialApp` theme
  Iterable<ThemeExtension<dynamic>> get extensions => {
        titleWrapperStyle ?? const TitleWrapperStyle(),
        selectorButtonStyle ?? const SelectorButtonStyle(),
        avilaSnackBarTheme ?? const AvilaSnackBarTheme(),
      };
}
