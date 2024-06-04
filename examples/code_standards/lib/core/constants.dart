import 'package:code_standards/core/typedefs/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'package:code_standards/l10n/l10n.dart';

export 'extensions/extensions.dart';

/// Here, you would define any constants that are used throughout your app.
/// Common examples include app name, margins, paddings, colors, fonts, common
/// URLs, and more. Do not include any sensitive information here, like API
/// keys or other credentials. For that, use environment variables instead.
class Consts {
  static const appName = "Avila Tek's Flutter Code Standards";

  // NOTE FOR DEVELOPERS: If you change either textStyle or textTheme, be sure
  // to update the other one as well.
  /// Text style for the app.
  static TextStyleBuilder textStyle = GoogleFonts.lato;

  /// Text theme for the app.
  static TextThemeBuilder textTheme = GoogleFonts.latoTextTheme;

  /// Page limit size for pagination.
  static const pageLimit = 25;

  /// Grid system's base value. The project uses an 8 point grid system.
  ///
  /// This means that the minimum size must be 8.0 and any other sizes must
  /// be multiples of this value.
  static const _gridSystem = 8.0;

  /// Default minimum padding size. The project uses an 8.0 point
  /// grid system.
  ///
  /// This means that the minimum padding size is 8.0, and any other sizes must
  /// be multiples of this value.
  static const padding = _gridSystem;

  /// Default margin size for widgets and screens. The margin follows the
  /// same grid system as the padding.
  static const margin = _gridSystem * 2;

  /// Default padding size to use between different sections.
  static const sectionPadding = _gridSystem * 4;

  /// Default padding size to use between different fields.
  static const fieldPadding = _gridSystem * 2;

  /// Default border radius value.
  static const defaultRadius = 8.0;
}

class AppColors {
  static Color font1(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? font1LightMode
          : font1DarkMode;
  static const Color font1LightMode = Color(0xFF101828);
  static const Color font1DarkMode = Color(0xFFF3F3F3);

  static Color font2(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? font2LightMode
          : font2DarkMode;
  static const Color font2LightMode = Color(0xFF475467);
  static const Color font2DarkMode = Color(0xFFD1D7E1);

  static Color dividerColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? dividerColorLightMode
          : dividerColorDarkMode;
  static const Color dividerColorLightMode = Color(0xFFF3F3F3);
  static const Color dividerColorDarkMode = Color(0xFF475467);

  /// NOTE: Handy method to get color based on brightness.
  static Color surface1(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? surface1LightMode
          : surface1DarkMode;
  static const Color surface1LightMode = Color(0xFFFEFEFE);
  static const Color surface1DarkMode = Color(0xFF221F1F);

  static Color surface2(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? surface2LightMode
          : surface2DarkMode;
  static const Color surface2LightMode = Color(0xFFF9FAFB);
  static const Color surface2DarkMode = Color(0xFFF9FAFB);

  static MaterialColor neutral(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? neutralLightMode
          : neutralDarkMode;
  static const MaterialColor neutralLightMode = Colors.blueGrey;
  static const MaterialColor neutralDarkMode = Colors.grey;

  // (I know, primaryColor's light and dark mode are the same, this is only for
  // demonstration purposes)

  static MaterialColor primaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? primaryColorLightMode
          : primaryColorDarkMode;
  static const MaterialColor primaryColorLightMode =
      MaterialColor(_primaryOneSeedValue, <int, Color>{
    50: Color(0xFFe1f5fa),
    100: Color(0xFFb4e7f1),
    200: Color(0xFF86d8e8),
    300: Color(0xFF5dc8dd),
    400: Color(0xFF47bcd4),
    500: Color(_primaryOneSeedValue),
    600: Color(0xFF35a2ba),
    700: Color(0xFF2f8ea0),
    800: Color(0xFF287a88),
    900: Color(0xFF1c585e),
  });
  static const MaterialColor primaryColorDarkMode =
      MaterialColor(_primaryOneSeedValue, <int, Color>{
    50: Color(0xFFe1f5fa),
    100: Color(0xFFb4e7f1),
    200: Color(0xFF86d8e8),
    300: Color(0xFF5dc8dd),
    400: Color(0xFF47bcd4),
    500: Color(_primaryOneSeedValue),
    600: Color(0xFF35a2ba),
    700: Color(0xFF2f8ea0),
    800: Color(0xFF287a88),
    900: Color(0xFF1c585e),
  });

  static const int _primaryOneSeedValue = 0xFF35B9D5;

  static MaterialColor secondaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? secondaryColorLightMode
          : secondaryColorDarkMode;

  static const MaterialColor secondaryColorLightMode =
      MaterialColor(_primaryTwoSeedValue, <int, Color>{
    50: Color(0xFFffe4ec),
    100: Color(0xFFffbacf),
    200: Color(0xFFff8db0),
    300: Color(0xFFfe5c8f),
    400: Color(0xFFfc3276),
    500: Color(0xFFf8005e),
    600: Color(0xFFe7005c),
    700: Color(0xFFd10058),
    800: Color(0xFFbc0055),
    900: Color(0xFF97004f),
  });
  static const MaterialColor secondaryColorDarkMode =
      MaterialColor(_primaryTwoSeedValue, <int, Color>{
    50: Color(0xFFffe4ec),
    100: Color(0xFFffbacf),
    200: Color(0xFFff8db0),
    300: Color(0xFFfe5c8f),
    400: Color(0xFFfc3276),
    500: Color(0xFFf8005e),
    600: Color(0xFFe7005c),
    700: Color(0xFFd10058),
    800: Color(0xFFbc0055),
    900: Color(0xFF97004f),
  });
  static const int _primaryTwoSeedValue = 0xFFfc3276;

  static const MaterialColor success =
      MaterialColor(_successPrimaryValue, <int, Color>{
    50: Color(0xFFECFDF3),
    100: Color(0xFFD1FADF),
    200: Color(0xFFA6F4C5),
    300: Color(0xFF6CE9A6),
    400: Color(0xFF32D583),
    500: Color(_successPrimaryValue),
    600: Color(0xFF039855),
    700: Color(0xFF027A48),
    800: Color(0xFF05603A),
    900: Color(0xFF054F31),
  });
  static const int _successPrimaryValue = 0xFF12B76A;

  static const MaterialColor warning =
      MaterialColor(_warningPrimaryValue, <int, Color>{
    50: Color(0xFFFFFAEB),
    100: Color(0xFFFEF0C7),
    200: Color(0xFFFEDF89),
    300: Color(0xFFFEC84B),
    400: Color(_warningPrimaryValue),
    500: Color(0xFFF79009),
    600: Color(0xFFDC6803),
    700: Color(0xFFB54708),
    800: Color(0xFF93370D),
    900: Color(0xFF7A2E0E),
  });
  static const int _warningPrimaryValue = 0xFFFDB022;

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
