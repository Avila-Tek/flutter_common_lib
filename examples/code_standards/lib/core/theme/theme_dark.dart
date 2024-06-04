part of 'theme.dart';

class DarkTheme {
  static ThemeData theme(BuildContext context) => ThemeData(
        appBarTheme: _CustomThemeValuesDarkMode.appBarTheme(context),
        cardColor: AppColors.dividerColorDarkMode,
        cardTheme: _CustomThemeValuesDarkMode.cardTheme(context),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.primaryColorDarkMode,
          accentColor: AppColors.secondaryColorDarkMode,
        ),
        dividerTheme: _CustomThemeValuesDarkMode.dividerTheme(context),
        elevatedButtonTheme:
            _CustomThemeValuesDarkMode.elevatedButtonTheme(context),
        inputDecorationTheme:
            _CustomThemeValuesDarkMode.inputDecorationTheme(context),
        listTileTheme: _CustomThemeValuesDarkMode.listTileThemeData(context),
        outlinedButtonTheme:
            _CustomThemeValuesDarkMode.outlinedButtonTheme(context),
        scaffoldBackgroundColor: AppColors.surface1DarkMode,
        textTheme: _CustomThemeValuesDarkMode.textTheme(context),
        textButtonTheme: _CustomThemeValuesDarkMode.textButtonTheme(context),
      );
}

class _CustomThemeValuesDarkMode {
  static TextTheme textTheme(BuildContext context) =>
      Consts.textTheme(Theme.of(context).textTheme).copyWith(
        titleLarge: Consts.textStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.font2DarkMode,
        ),
        titleSmall: Consts.textStyle(fontWeight: FontWeight.w600),
        headlineMedium: Consts.textStyle(
          color: AppColors.font1DarkMode,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: Consts.textStyle(
          color: AppColors.font1DarkMode,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: Consts.textStyle(
          color: AppColors.font1DarkMode,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: Consts.textStyle(fontWeight: FontWeight.w700),
        labelMedium: Consts.textStyle(fontWeight: FontWeight.w400),
      );

  static TextButtonThemeData textButtonTheme(BuildContext context) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColorDarkMode,
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
        color: AppColors.surface1DarkMode,
        elevation: 0,
        titleTextStyle: Consts.textStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColorDarkMode,
        ),
        centerTitle: true,
        foregroundColor: AppColors.primaryColorDarkMode,
        shadowColor: Colors.black26,
      );

  static CardTheme cardTheme(BuildContext context) => CardTheme(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 4),
        shadowColor: Colors.black26,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.defaultRadius * 1.5),
          side: const BorderSide(color: AppColors.dividerColorDarkMode),
        ),
      );

  static DividerThemeData dividerTheme(BuildContext context) =>
      const DividerThemeData(
        color: AppColors.dividerColorDarkMode,
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
                    ? AppColors.primaryColorDarkMode.shade100
                    : isPressed
                        ? AppColors.primaryColorDarkMode.shade200
                        : AppColors.primaryColorDarkMode.shade500,
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
            disabledBackgroundColor: AppColors.primaryColorDarkMode.shade100,
            backgroundColor: AppColors.primaryColorDarkMode.shade400,
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
          foregroundColor: AppColors.primaryColorDarkMode,
          side: const BorderSide(
            color: AppColors.primaryColorDarkMode,
            width: 1.5,
          ),
          shape: const StadiumBorder(),
        ),
      );

  static InputDecorationTheme inputDecorationTheme(BuildContext context) {
    final inputBorderColor = AppColors.neutralDarkMode.shade200;
    return InputDecorationTheme(
      isDense: true,
      border: MaterialStateOutlineInputBorder.resolveWith(
        (states) {
          Color foregroundColor;
          if (states.contains(MaterialState.disabled)) {
            foregroundColor = inputBorderColor;
          } else if (states.contains(MaterialState.focused)) {
            foregroundColor = AppColors.primaryColorDarkMode;
          } else {
            foregroundColor = AppColors.primaryColorDarkMode;
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
      hintStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(color: inputBorderColor);
        }
        return Consts.textStyle(
          color: AppColors.font1DarkMode,
          fontWeight: FontWeight.w500,
        );
      }),
      prefixIconColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.neutralDarkMode.shade50;
          }
          if (states.contains(MaterialState.focused)) {
            return AppColors.secondaryColorDarkMode.shade400;
          }
          return AppColors.secondaryColorDarkMode.shade50;
        },
      ),
      suffixIconColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.neutralDarkMode.shade50;
          }
          if (states.contains(MaterialState.focused)) {
            return AppColors.primaryColorDarkMode.shade400;
          }
          return inputBorderColor;
        },
      ),
    );
  }
}
