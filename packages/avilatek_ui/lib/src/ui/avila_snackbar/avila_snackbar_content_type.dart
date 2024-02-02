// ignore_for_file: lines_longer_than_80_chars

import 'package:avilatek_ui/src/ui/avila_snackbar/default_avila_snackbar_colors.dart';
import 'package:flutter/material.dart';

/// to handle failure, success, help and warning `AvilaSnackBarContentType` class is being used
class AvilaSnackBarContentType {
  /// `SnackbarContentType` constructor
  ///
  /// `message` is `required` parameter
  ///
  /// `color` is optional, if provided null then `DefaultAvilaSnackBarColors` will be used
  const AvilaSnackBarContentType(this.message, [this.color]);

  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultAvilaSnackBarColors` will be used
  final Color? color;

  /// `SnackbarContentType` for `help`
  static const AvilaSnackBarContentType help =
      AvilaSnackBarContentType('help', DefaultAvilaSnackBarColors.helpBlue);

  /// `SnackbarContentType` for `failure`
  static const AvilaSnackBarContentType failure = AvilaSnackBarContentType(
    'failure',
    DefaultAvilaSnackBarColors.failureRed,
  );

  /// `SnackbarContentType` for `success`
  static const AvilaSnackBarContentType success = AvilaSnackBarContentType(
    'success',
    DefaultAvilaSnackBarColors.successGreen,
  );

  /// `SnackbarContentType` for `warning`
  static const AvilaSnackBarContentType warning = AvilaSnackBarContentType(
    'warning',
    DefaultAvilaSnackBarColors.warningYellow,
  );
}
