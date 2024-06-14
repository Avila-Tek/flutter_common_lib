part of 'theme.dart';

class LightTheme {
  static ThemeData theme(BuildContext context) => ThemeData(
        appBarTheme: _CustomThemeValuesLightMode.appBarTheme(context),
        cardColor: AppColors.dividerColorLightMode,
        cardTheme: _CustomThemeValuesLightMode.cardTheme(context),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.primaryColorLightMode,
          accentColor: AppColors.secondaryColorLightMode,
        ),
        dividerTheme: _CustomThemeValuesLightMode.dividerTheme(context),
        elevatedButtonTheme:
            _CustomThemeValuesLightMode.elevatedButtonTheme(context),
        inputDecorationTheme:
            _CustomThemeValuesLightMode.inputDecorationTheme(context),
        listTileTheme: _CustomThemeValuesLightMode.listTileThemeData(context),
        outlinedButtonTheme:
            _CustomThemeValuesLightMode.outlinedButtonTheme(context),
        scaffoldBackgroundColor: AppColors.surface1LightMode,
        textTheme: _CustomThemeValuesLightMode.textTheme(context),
        textButtonTheme: _CustomThemeValuesLightMode.textButtonTheme(context),
      );
}

class _CustomThemeValuesLightMode {
  static TextTheme textTheme(BuildContext context) =>
      Consts.textTheme(Theme.of(context).textTheme).copyWith(
        titleLarge: Consts.textStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.font2LightMode,
        ),
        titleSmall: Consts.textStyle(fontWeight: FontWeight.w600),
        headlineMedium: Consts.textStyle(
          color: AppColors.font1LightMode,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: Consts.textStyle(
          color: AppColors.font1LightMode,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: Consts.textStyle(
          color: AppColors.font1LightMode,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: Consts.textStyle(fontWeight: FontWeight.w700),
        labelMedium: Consts.textStyle(fontWeight: FontWeight.w400),
      );

  static TextButtonThemeData textButtonTheme(BuildContext context) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColorLightMode,
        ),
      );

  static ListTileThemeData listTileThemeData(BuildContext context) =>
      const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          vertical: Consts.padding,
          horizontal: Consts.margin,
        ),
      );

  static AppBarTheme appBarTheme(BuildContext context) => AppBarTheme(
        color: AppColors.surface1LightMode,
        elevation: 0,
        titleTextStyle: Consts.textStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        shadowColor: Colors.black26,
      );

  static CardTheme cardTheme(BuildContext context) => CardTheme(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 4),
        shadowColor: Colors.black26,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.defaultRadius * 1.5),
          side: const BorderSide(color: AppColors.dividerColorLightMode),
        ),
      );

  static DividerThemeData dividerTheme(BuildContext context) =>
      const DividerThemeData(
        color: AppColors.dividerColorLightMode,
        thickness: 0.5,
        space: 0,
      );

  static ElevatedButtonThemeData elevatedButtonTheme(BuildContext context) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith((states) {
            final isDisabled = states.contains(MaterialState.disabled);
            final isPressed = states.contains(MaterialState.pressed);
            return StadiumBorder(
              side: BorderSide(
                color: isDisabled
                    ? AppColors.primaryColorLightMode.shade100
                    : isPressed
                        ? AppColors.primaryColorLightMode.shade200
                        : AppColors.primaryColorLightMode.shade500,
                width: 1.76,
              ),
            );
          }),
        ).merge(
          ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: Consts.padding * 1.75,
              horizontal: Consts.padding * 3,
            ),
            disabledBackgroundColor: AppColors.primaryColorLightMode.shade100,
            backgroundColor: AppColors.primaryColorLightMode.shade400,
            foregroundColor: Colors.white,
          ),
        ),
      );

  static OutlinedButtonThemeData outlinedButtonTheme(BuildContext context) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: Consts.padding * 1.5,
            horizontal: Consts.padding * 3,
          ),
          foregroundColor: AppColors.primaryColorLightMode,
          side: const BorderSide(
            color: AppColors.primaryColorLightMode,
            width: 1.5,
          ),
          shape: const StadiumBorder(),
        ),
      );

  static InputDecorationTheme inputDecorationTheme(BuildContext context) {
    final inputBorderColor = AppColors.neutralLightMode.shade200;
    return InputDecorationTheme(
      isDense: true,
      border: MaterialStateOutlineInputBorder.resolveWith(
        (states) {
          Color foregroundColor;
          if (states.contains(MaterialState.disabled)) {
            foregroundColor = inputBorderColor;
          } else if (states.contains(MaterialState.focused)) {
            foregroundColor = AppColors.primaryColorLightMode;
          } else {
            foregroundColor = AppColors.primaryColorLightMode;
          }

          return OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(Consts.defaultRadius),
            ),
            borderSide: BorderSide(color: foregroundColor, width: 1.5),
          );
        },
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: Consts.padding * 3,
      ),
      // hintStyle: MaterialStateTextStyle.resolveWith((states) {
      //   if (states.contains(MaterialState.disabled)) {
      //     return TextStyle(color: inputBorderColor);
      //   }
      //   return Consts.textStyle(
      //     color: AppColors.font1LightMode,
      //     fontWeight: FontWeight.w500,
      //   );
      // }),
      prefixIconColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.neutralLightMode.shade50;
          }
          if (states.contains(MaterialState.focused)) {
            return AppColors.secondaryColorLightMode.shade400;
          }
          return AppColors.secondaryColorLightMode.shade50;
        },
      ),
      suffixIconColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.neutralLightMode.shade50;
          }
          if (states.contains(MaterialState.focused)) {
            return AppColors.primaryColorLightMode.shade400;
          }
          return inputBorderColor;
        },
      ),
    );
  }
}
