import 'package:code_standards/core/constants.dart';
import 'package:flutter/material.dart';

part 'theme_dark.dart';
part 'theme_light.dart';

/// Here, you would define any custom theme data that is used throughout your
/// app.
class AppTheme {
  static ThemeData themeLightMode(BuildContext context) =>
      LightTheme.theme(context);

  static ThemeData themeDarkMode(BuildContext context) =>
      LightTheme.theme(context);
}
