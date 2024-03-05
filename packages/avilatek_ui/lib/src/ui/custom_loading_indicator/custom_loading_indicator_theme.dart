// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:flutter/material.dart';

/// [CustomLoadingIndicatorThemeData] defines the theme
@immutable
class CustomLoadingIndicatorThemeData extends ThemeExtension<CustomLoadingIndicatorThemeData> {
  ///creates an [CustomLoadingIndicatorThemeData]
  const CustomLoadingIndicatorThemeData({
    this.child,
  });

  ///defines the child for the widget
  final Widget? child;

  /// Creates a copy of this [CustomLoadingIndicatorThemeData] but with the given fields
  /// replaced with the new values. This method is typically used to adjust the properties
  /// of a [CustomLoadingIndicatorThemeData] instance to create a new one.
  ///
  /// The [child] parameter is optional. If provided, it replaces the existing child.
  /// If it is not provided, the existing child is used.
  ///
  /// If both the existing child and the provided child are null, a [FlutterError] is thrown.
  /// This is because a [CustomLoadingIndicatorThemeData] must always have a non-null child.
  ///
  /// Returns a new [CustomLoadingIndicatorThemeData] with the provided properties replaced.
  @override
  CustomLoadingIndicatorThemeData copyWith({
    Widget? child,
  }) {
    if (child == null && this.child == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('child must be non-null.'),
      ]);
    }
    // Return a new CustomLoadingIndicatorThemeData with the provided properties replaced.
    // If a property is not provided, the existing property is used.
    return CustomLoadingIndicatorThemeData(
      child: child ?? this.child,
    );
  }

  @override
  ThemeExtension<CustomLoadingIndicatorThemeData> lerp(
    covariant ThemeExtension<CustomLoadingIndicatorThemeData>? other,
    double t,
  ) {
    if (identical(this, other)) {
      return this;
    }
    if (other == null) {
      return this;
    }
    if (t < 0.5) {
      return this;
    } else {
      return other;
    }
  }
}
