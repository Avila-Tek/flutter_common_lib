// ignore_for_file: omit_local_variable_types

import 'package:avilatek_ui/src/ui/avila_theme_data.dart';
import 'package:flutter/cupertino.dart';

/// Applies a theme to descendant widgets.
///
/// A theme describes the colors and typographic choices of an application.
class AvilaTheme extends StatelessWidget {
  /// Applies the given theme [data] to [child].
  const AvilaTheme({
    required this.data,
    required this.child,
    super.key,
  });

  /// Specifies the color and typography values for descendant widgets.
  final AvilaThemeData data;

  /// The widget below this widget in the tree.
  final Widget child;

  static final AvilaThemeData _kFallbackTheme = AvilaThemeData.fallback();

  /// The data from the closest [AvilaTheme] instance that encloses the given
  /// context.
  static AvilaThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();

    // final MaterialLocalizations? localizations =
    //     Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    // final ScriptCategory category =
    //     localizations?.scriptCategory ?? ScriptCategory.englishLike;
    final AvilaThemeData data = inheritedTheme?.theme.data ?? _kFallbackTheme;

    return data;

    // return ThemeData.localize(
    //     theme, theme.typography.geometryThemeFor(category));
  }

  // TODO: Delete if not needed.
  // The inherited themes in widgets library can not infer their values from
  // Theme in material library. Wraps the child with these inherited themes to
  // overrides their values directly.
  // Widget _wrapsWidgetThemes(BuildContext context, Widget child) {
  //   final DefaultSelectionStyle selectionStyle =
  //       DefaultSelectionStyle.of(context);
  //   return IconTheme(
  //     data: data.iconTheme,
  //     child: DefaultSelectionStyle(
  //       selectionColor: data.textSelectionTheme.selectionColor ??
  //           selectionStyle.selectionColor,
  //       cursorColor:
  //           data.textSelectionTheme.cursorColor ?? selectionStyle.cursorColor,
  //       child: child,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: AvilaTheme(data: data, child: child),
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    required this.theme,
    required super.child,
  });

  final AvilaTheme theme;

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme != old.theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AvilaTheme(data: theme.data, child: child);
  }
}
