import 'package:flutter/material.dart';

/// This contants class was generated with Mason. You can use it to define your
/// color palette for your app. Please remember to fill the values with your
/// desired hexcode colors.
class ColorConstants {
  static const MaterialColor brandColor =
      MaterialColor(_brandColorPrimaryValue, <int, Color>{
    50: Color(0xFF), // TODO: Fill this with shade 50 of the primary color
    100: Color(0xFF), // TODO: Fill this with shade 100 of the primary color
    200: Color(0xFF), // TODO: Fill this with shade 200 of the primary color
    300: Color(0xFF), // TODO: Fill this with shade 300 of the primary color
    400: Color(0xFF), // TODO: Fill this with shade 400 of the primary color
    500: Color(_brandColorPrimaryValue),
    600: Color(0xFF), // TODO: Fill this with shade 600 of the primary color
    700: Color(0xFF), // TODO: Fill this with shade 700 of the primary color
    800: Color(0xFF), // TODO: Fill this with shade 800 of the primary color
    900: Color(0xFF), // TODO: Fill this with shade 900 of the primary color
  });

  // TODO: Fill this value with the primary color value
  static const int _brandColorPrimaryValue = 0xFF;
  {{#project_includes_secondary_color}}
  
  static const MaterialColor secondaryColor =
      MaterialColor(_secondaryColorValue, <int, Color>{
    50: Color(0xFF), // TODO: Fill this with shade 50 of the secondary color
    100: Color(0xFF), // TODO: Fill this with shade 100 of the secondary color
    200: Color(0xFF), // TODO: Fill this with shade 200 of the secondary color
    300: Color(0xFF), // TODO: Fill this with shade 300 of the secondary color
    400: Color(0xFF), // TODO: Fill this with shade 400 of the secondary color
    500: Color(_secondaryColorValue),
    600: Color(0xFF), // TODO: Fill this with shade 600 of the secondary color
    700: Color(0xFF), // TODO: Fill this with shade 700 of the secondary color
    800: Color(0xFF), // TODO: Fill this with shade 800 of the secondary color
    900: Color(0xFF), // TODO: Fill this with shade 900 of the secondary color
  });

  // TODO: Fill this value with the secondary color value
  static const int _secondaryColorValue = 0xFF;
  {{/project_includes_secondary_color}}

  static const MaterialColor grayLight =
      MaterialColor(_grayLightPrimaryValue, <int, Color>{
    50: Color(0xFFF9FAFB),
    100: Color(0xFFF2F4F7),
    200: Color(0xFFEAECF0),
    300: Color(0xFFD0D5DD),
    400: Color(0xFF98A2B3),
    500: Color(_grayLightPrimaryValue),
    600: Color(0xFF475467),
    700: Color(0xFF344054),
    800: Color(0xFF1D2939),
    900: Color(0xFF101828),
  });

  static const int _grayLightPrimaryValue = 0xFF667085;

  static const MaterialColor grayDark =
      MaterialColor(_grayDarkPrimaryValue, <int, Color>{
    50: Color(0xFFF9FAFB),
    100: Color(0xFFF2F4F7),
    200: Color(0xFFEAECF0),
    300: Color(0xFFD0D5DD),
    400: Color(0xFF94969C),
    500: Color(_grayDarkPrimaryValue),
    600: Color(0xFF62646B),
    700: Color(0xFF344054),
    800: Color(0xFF1D2939),
    900: Color(0xFF101828),
  });

  static const int _grayDarkPrimaryValue = 0xFF85888D;

  static const MaterialColor success =
      MaterialColor(_successPrimaryValue, <int, Color>{
    50: Color(0xFFE3F6ED),
    100: Color(0xFFB8E9D2),
    200: Color(0xFF89DBB5),
    300: Color(0xFF59CD97),
    400: Color(0xFF36C280),
    500: Color(_successPrimaryValue),
    600: Color(0xFF10B062),
    700: Color(0xFF0DA757),
    800: Color(0xFF0A9F4D),
    900: Color(0xFF05903C),
  });
  static const int _successPrimaryValue = 0xFF12B76A;

  static const MaterialColor warning =
      MaterialColor(_warningPrimaryValue, <int, Color>{
    50: Color(0xFFFEF2E1),
    100: Color(0xFFFDDEB5),
    200: Color(0xFFFBC884),
    300: Color(0xFFF9B153),
    400: Color(0xFFF8A12E),
    500: Color(_warningPrimaryValue),
    600: Color(0xFFF68808),
    700: Color(0xFFF57D06),
    800: Color(0xFFF37305),
    900: Color(0xFFF16102),
  });
  static const int _warningPrimaryValue = 0xFFF79009;

  static const MaterialColor error =
      MaterialColor(_errorPrimaryValue, <int, Color>{
    50: Color(0xFFFDE9E7),
    100: Color(0xFFFBC7C3),
    200: Color(0xFFF8A29C),
    300: Color(0xFFF57C74),
    400: Color(0xFFF26056),
    500: Color(_errorPrimaryValue),
    600: Color(0xFFEE3E32),
    700: Color(0xFFEC352B),
    800: Color(0xFFE92D24),
    900: Color(0xFFE51F17),
  });
  static const int _errorPrimaryValue = 0xFFF04438;
}
