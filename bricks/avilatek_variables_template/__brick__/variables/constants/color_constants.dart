part of 'package:{{full_path}}/variables/values/color_values.dart';

/// This contants class was generated with Mason. You can use it to define your
/// color palette for your app. Please remember to fill the values with your
/// desired hexcode colors.
class _ColorConstants {
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
    200: Color(0xFFE4E7EC),
    300: Color(0xFFD0D5DD),
    400: Color(0xFF98A2B3),
    500: Color(_grayLightPrimaryValue),
    600: Color(0xFF475467),
    700: Color(0xFF344054),
    800: Color(0xFF182230),
    900: Color(0xFF101828),
  });

  static const int _grayLightPrimaryValue = 0xFF667085;

  static const MaterialColor grayDark =
      MaterialColor(_grayDarkPrimaryValue, <int, Color>{
    50: Color(0xFFF5F5F6),
    100: Color(0xFFF0F1F1),
    200: Color(0xFFECECED),
    300: Color(0xFFCECFD2),
    400: Color(0xFF94969C),
    500: Color(_grayDarkPrimaryValue),
    600: Color(0xFF61646C),
    700: Color(0xFF333741),
    800: Color(0xFF1F242F),
    900: Color(0xFF161B26),
  });

  static const int _grayDarkPrimaryValue = 0xFF85888E;

  static const MaterialColor success =
      MaterialColor(_successPrimaryValue, <int, Color>{
    50: Color(0xFFECFDF3),
    100: Color(0xFFDCFAE6),
    200: Color(0xFFABEFC6),
    300: Color(0xFF75E0A7),
    400: Color(0xFF47CD89),
    500: Color(_successPrimaryValue),
    600: Color(0xFF079455),
    700: Color(0xFF067647),
    800: Color(0xFF085D3A),
    900: Color(0xFF074D31),
  });
  static const int _successPrimaryValue = 0xFF17B26A;

  static const MaterialColor warning =
      MaterialColor(_warningPrimaryValue, <int, Color>{
    50: Color(0xFFFFFAEB), 
    100: Color(0xFFFEF0C7),
    200: Color(0xFFFEDF89),
    300: Color(0xFFFEC84B),
    400: Color(0xFFFDB022),
    500: Color(_warningPrimaryValue),
    600: Color(0xFFDC6803),
    700: Color(0xFFB54708),
    800: Color(0xFF93370D),
    900: Color(0xFF7A2E0E),
  });
  static const int _warningPrimaryValue = 0xFFF79009;

  static const MaterialColor error =
      MaterialColor(_errorPrimaryValue, <int, Color>{
    50: Color(0xFFFEF3F2),
    100: Color(0xFFFEE4E2),
    200: Color(0xFFFECDCA),
    300: Color(0xFFFDA29B),
    400: Color(0xFFF97066),
    500: Color(_errorPrimaryValue),
    600: Color(0xFFD92D20),
    700: Color(0xFFB42318),
    800: Color(0xFF912018),
    900: Color(0xFF7A271A),
  });
  static const int _errorPrimaryValue = 0xFFF04438;
}
