// ignore_for_file: lines_longer_than_80_chars

import 'package:avilatek_ui/src/ui/avila_snackbar/default_avila_snackbar_colors.dart';
import 'package:flutter/material.dart';

/// to handle failure, success, help and warning `AvilaSnackbarContentType` class is being used
class AvilaSnackbarContentType {
  /// `SnackbarContentType` constructor
  ///
  /// `message` is `required` parameter
  ///
  /// `color` is optional, if provided null then `DefaultAvilaSnackbarColors` will be used
  const AvilaSnackbarContentType(this.message, [this.color]);

  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultAvilaSnackbarColors` will be used
  final Color? color;

  /// `SnackbarContentType` for `help`
  static const AvilaSnackbarContentType help =
      AvilaSnackbarContentType('help', DefaultAvilaSnackbarColors.helpBlue);

  /// `SnackbarContentType` for `failure`
  static const AvilaSnackbarContentType failure = AvilaSnackbarContentType(
    'failure',
    DefaultAvilaSnackbarColors.failureRed,
  );

  /// `SnackbarContentType` for `success`
  static const AvilaSnackbarContentType success = AvilaSnackbarContentType(
    'success',
    DefaultAvilaSnackbarColors.successGreen,
  );

  /// `SnackbarContentType` for `warning`
  static const AvilaSnackbarContentType warning = AvilaSnackbarContentType(
    'warning',
    DefaultAvilaSnackbarColors.warningYellow,
  );
}
