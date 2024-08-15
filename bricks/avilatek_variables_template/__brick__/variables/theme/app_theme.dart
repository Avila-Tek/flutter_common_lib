import 'package:flutter/material.dart';
import 'package:{{full_path}}/variables/values/color_values.dart';
import 'package:{{full_path}}/variables/values/text_values.dart';
import 'package:{{full_path}}/variables/values/width_values.dart';

class AppTheme {
  static ThemeData theme(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ThemeData(
      brightness: brightness,
      primaryColor: ColorValues.utilityBrand500(context),
      useMaterial3: false,
      appBarTheme: _CustomThemeValues.appBarTheme(context),
      textTheme: _CustomThemeValues.textTheme(context),
      elevatedButtonTheme: _CustomThemeValues.elevatedButtonTheme(context),
      outlinedButtonTheme: _CustomThemeValues.outlinedButtonTheme(context),
      iconTheme: _CustomThemeValues.iconTheme(context),
      canvasColor: ColorValues.bgSecondary(context),
      dialogTheme: _CustomThemeValues.dialogTheme(context),
      cardTheme: _CustomThemeValues.cardTheme(context),
      dividerTheme: _CustomThemeValues.dividerTheme(context),
    );
  }
}

/// This class contains custom theme values for the app. These values are merely
/// suggestions and can be customized to fit your app's design. Feel free to
/// update them, always following the guidelines stablished in Figma
class _CustomThemeValues {
  static TextTheme textTheme(BuildContext context) =>
      TextValues.fontFamily(context).copyWith(
        displayLarge: TextStyle(
          color: ColorValues.textPrimary(context),
          fontWeight: TextValues.bold,
          fontSize: TextValues.displayMd,
        ),
        displayMedium: TextStyle(
          color: ColorValues.textPrimary(context),
          fontWeight: TextValues.bold,
          fontSize: TextValues.displaySm,
        ),
        displaySmall: TextStyle(
          color: ColorValues.textPrimary(context),
          fontWeight: TextValues.bold,
          fontSize: TextValues.displayXs,
        ),
        titleLarge: TextStyle(
          color: ColorValues.textPrimary(context),
          fontWeight: TextValues.bold,
          fontSize: TextValues.displayXs,
        ),
        titleSmall: TextStyle(
          color: ColorValues.textPrimary(context),
          fontWeight: TextValues.semibold,
          fontSize: TextValues.textXl,
        ),
        headlineMedium: TextStyle(
          color: ColorValues.textSecondary(context),
          fontWeight: TextValues.semibold,
          fontSize: TextValues.textLg,
        ),
        bodyMedium: TextStyle(
          color: ColorValues.textTertiary(context),
          fontWeight: TextValues.regular,
          fontSize: TextValues.textSm,
        ),
        bodySmall: TextStyle(
          color: ColorValues.textQuaternary(context),
          fontWeight: TextValues.regular,
          fontSize: TextValues.textXs,
        ),
      );

  static ElevatedButtonThemeData elevatedButtonTheme(BuildContext context) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith(
            (states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(WidthValues.radiusMd),
              );
            },
          ),
        ).merge(
          ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(
              vertical: WidthValues.spacing2Md,
              horizontal: WidthValues.spacingXl,
            ),
            disabledBackgroundColor: ColorValues.bgDisabled(context),
            backgroundColor: ColorValues.bgBrandSolid(context),
            foregroundColor: ColorValues.fgWhite(context),
            textStyle: const TextStyle(
              fontWeight: TextValues.semibold,
              fontSize: TextValues.textSm,
            ),
          ),
        ),
      );

  static OutlinedButtonThemeData outlinedButtonTheme(BuildContext context) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: WidthValues.spacingMd,
            horizontal: WidthValues.spacingXl,
          ),
          foregroundColor: ColorValues.fgBrandPrimaryAlt(context),
          side: BorderSide(
            color: ColorValues.borderBrandAlt(context),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WidthValues.radiusMd),
          ),
          textStyle: const TextStyle(
            fontWeight: TextValues.semibold,
            fontSize: TextValues.textSm,
          ),
        ),
      );

  static IconThemeData iconTheme(BuildContext context) => IconThemeData(
        color: ColorValues.featuredIconFgBrand(context),
        size: 24,
      );

  static AppBarTheme appBarTheme(BuildContext context) => AppBarTheme(
        color: ColorValues.bgPrimary(context),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: ColorValues.textBrandPrimary(context),
        ),
        actionsIconTheme:
            IconThemeData(color: ColorValues.fgQuaternary(context)),
        shadowColor: ColorValues.utilityGray100(context),
      );

  static DialogTheme dialogTheme(BuildContext context) => DialogTheme(
        backgroundColor: ColorValues.bgOverlay(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WidthValues.radiusMd),
        ),
      );

  static CardTheme cardTheme(BuildContext context) => CardTheme(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: WidthValues.padding),
        shadowColor: Colors.black26,
        color: ColorValues.bgPrimary(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WidthValues.radiusMd),
          side: BorderSide(color: ColorValues.borderSecondary(context)),
        ),
      );

  static DividerThemeData dividerTheme(BuildContext context) =>
      DividerThemeData(
        color: ColorValues.borderDisabledSubtle(context),
        thickness: 0.5,
        space: 0,
      );
}
