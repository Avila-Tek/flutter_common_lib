import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// Returns the [ThemeData] of the current context.
  ThemeData get theme => Theme.of(this);

  /// Returns the [ThemeData] of the current context.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the [MediaQueryData] of the current context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
