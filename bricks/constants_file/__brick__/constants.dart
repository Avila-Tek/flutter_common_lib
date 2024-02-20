import 'package:flutter/material.dart';
import 'dart:math';


  /// This Consts file was generated using Mason. You can customize it to fit your needs.
  /// Feel free to add any constants that you think will be useful for your project.
class Consts {

  /// The name of the app.
  static const appName = '{{{app_name}}}';

  /// Grid system's base value. The project uses an {{{grid_system}}} point grid system.
  ///
  /// This means that the minimum size must be {{{grid_system}}} and any other sizes must
  /// be multiples of this value.
  static const _gridSystem = {{grid_system}};

  /// Default minimum padding size. The project uses an {{{grid_system}}} point
  /// grid system.
  ///
  /// This means that the minimum padding size is {{{grid_system}}}, and any other sizes must
  /// be multiples of this value.
  static const padding = _gridSystem;

  /// Default margin size for widgets and screens. The margin follows the
  /// same grid system as the padding.
  static const margin = padding * 2;

  /// Default padding size to use between different sections.
  ///
  /// See [Section] widget for more information.
  static const sectionPadding = padding * 4;

  /// Default padding size to use between different fields.
  ///
  /// Usually used to separate [CustomField] widgets, but can be used
  /// to separate any other widgets inside a list or column.
  static const fieldPadding = padding * 2;

  /// Default border radius value.
  static const defaultRadius = {{default_radius}};

  static const bottomPadding = _gridSystem * 5;

  // <---------------- Colors ------------------>

  static const Color fontWhite = Color(0xFF{{font_white}});
  static const Color fontBlack = Color(0xFF{{font_black}});

  static const Color _primaryOneSeedValue = Color(0xFF{{primary_color_seed_value}});
  static final MaterialColor primaryOne = generateMaterialColor(_primaryOneSeedValue);
  {{#project_includes_secondary_color}}
  
  static const Color _secondaryOneSeedValue = Color(0xFF{{secondary_color_seed_value}});
  static final MaterialColor secondaryOne =
      generateMaterialColor(_secondaryOneSeedValue);
  {{/project_includes_secondary_color}}

  static const Color _successPrimaryValue = Color(0xFF{{success_color_seed_value}});
  static final MaterialColor success =
      generateMaterialColor(_successPrimaryValue);

  static const Color _warningPrimaryValue = Color(0xFF{{warning_color_seed_value}});
  static final MaterialColor warning =
      generateMaterialColor(_warningPrimaryValue);

  static const Color _errorPrimaryValue = Color(0xFF{{error_color_seed_value}});
  static final MaterialColor error =
      generateMaterialColor(_errorPrimaryValue);

  static MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.5),
    100: tintColor(color, 0.4),
    200: tintColor(color, 0.3),
    300: tintColor(color, 0.2),
    400: tintColor(color, 0.1),
    500: color,
    600: tintColor(color, -0.1),
    700: tintColor(color, -0.2),
    800: tintColor(color, -0.3),
    900: tintColor(color, -0.4),
  });
}

  static int tintValue(int value, double factor) => 
  max(0, min((value + (255 * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => 
  Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1,
  );

}
