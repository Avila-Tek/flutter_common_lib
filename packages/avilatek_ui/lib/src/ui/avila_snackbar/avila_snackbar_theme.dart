import 'package:flutter/material.dart';

class AvilaSnackBarTheme extends ThemeExtension<AvilaSnackBarTheme> {
  const AvilaSnackBarTheme({
    this.defaultThemeData,
    this.successThemeData,
    this.failureThemeData,
    this.infoThemeData,
    this.warningThemeData,
  });

  final SnackBarThemeData? defaultThemeData;
  final SnackBarThemeData? successThemeData;
  final SnackBarThemeData? failureThemeData;
  final SnackBarThemeData? infoThemeData;
  final SnackBarThemeData? warningThemeData;

  @override
  ThemeExtension<AvilaSnackBarTheme> copyWith({
    SnackBarThemeData? defaultThemeData,
    SnackBarThemeData? successThemeData,
    SnackBarThemeData? failureThemeData,
    SnackBarThemeData? infoThemeData,
    SnackBarThemeData? warningThemeData,
  }) =>
      AvilaSnackBarTheme(
        defaultThemeData: defaultThemeData ?? this.defaultThemeData,
        successThemeData: successThemeData ?? this.successThemeData,
        failureThemeData: failureThemeData ?? this.failureThemeData,
        infoThemeData: infoThemeData ?? this.infoThemeData,
        warningThemeData: warningThemeData ?? this.warningThemeData,
      );

  @override
  ThemeExtension<AvilaSnackBarTheme> lerp(
    covariant ThemeExtension<AvilaSnackBarTheme>? other,
    double t,
  ) {
    if (other is! AvilaSnackBarTheme) {
      return this;
    }

    return AvilaSnackBarTheme(
      defaultThemeData:
          SnackBarThemeData.lerp(defaultThemeData, other.defaultThemeData, t),
      successThemeData:
          SnackBarThemeData.lerp(successThemeData, other.successThemeData, t),
      failureThemeData:
          SnackBarThemeData.lerp(failureThemeData, other.failureThemeData, t),
      infoThemeData:
          SnackBarThemeData.lerp(infoThemeData, other.infoThemeData, t),
      warningThemeData:
          SnackBarThemeData.lerp(warningThemeData, other.warningThemeData, t),
    );
  }
}
