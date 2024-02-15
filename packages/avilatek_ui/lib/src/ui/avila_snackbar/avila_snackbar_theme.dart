// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

/// `AvilaSnackBarTheme` class is being used to handle the theme of `AvilaSnackBar`
/// for `default`, `success`, `failure`, `info` and `warning` snackbar types

class AvilaSnackBarTheme extends ThemeExtension<AvilaSnackBarTheme> {
  /// `AvilaSnackBarTheme` constructor
  const AvilaSnackBarTheme({
    this.defaultThemeData,
    this.successThemeData,
    this.failureThemeData,
    this.infoThemeData,
    this.warningThemeData,
  });

  /// [defaultThemeData] is used to handle the default theme of `AvilaSnackBar`
  final SnackBarThemeData? defaultThemeData;

  /// [successThemeData] is used to handle the success theme of `AvilaSnackBar`
  final SnackBarThemeData? successThemeData;

  /// [failureThemeData] is used to handle the failure theme of `AvilaSnackBar`
  final SnackBarThemeData? failureThemeData;

  /// [infoThemeData] is used to handle the info theme of `AvilaSnackBar`
  final SnackBarThemeData? infoThemeData;

  /// [warningThemeData] is used to handle the warning theme of `AvilaSnackBar`
  final SnackBarThemeData? warningThemeData;

  /// `copyWith` is used to copy the current `AvilaSnackBarTheme` and update the provided values
  /// and return a new `AvilaSnackBarTheme`
  ///
  /// [defaultThemeData] is used to update the default theme of `AvilaSnackBar`
  ///
  /// [successThemeData] is used to update the success theme of `AvilaSnackBar`
  ///
  /// [failureThemeData] is used to update the failure theme of `AvilaSnackBar`
  ///
  /// [infoThemeData] is used to update the info theme of `AvilaSnackBar`
  ///
  /// [warningThemeData] is used to update the warning theme of `AvilaSnackBar`
  ///
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

  /// `lerp` is used to linearly interpolate between two `AvilaSnackBarTheme`
  /// and return a new `AvilaSnackBarTheme`
  ///
  /// [other] is used to provide the other `AvilaSnackBarTheme` to interpolate with
  ///
  /// [t] is used to provide the value to interpolate
  ///
  /// returns a new `AvilaSnackBarTheme` after interpolation
  ///
  /// if [other] is not `AvilaSnackBarTheme` then it will return the current `AvilaSnackBarTheme`
  /// without any interpolation
  ///
  /// if [other] is `AvilaSnackBarTheme` then it will interpolate the `defaultThemeData`, `successThemeData`,
  /// `failureThemeData`, `infoThemeData` and `warningThemeData` and return a new `AvilaSnackBarTheme`
  ///
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
