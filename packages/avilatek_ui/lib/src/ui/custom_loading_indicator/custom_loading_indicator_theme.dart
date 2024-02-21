// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// [CustomLoadingIndicatorThemeData] defines the theme
@immutable
class CustomLoadingIndicatorThemeData extends 
ThemeExtension<CustomLoadingIndicatorThemeData> {
  ///creates an [CustomLoadingIndicatorThemeData]
  const CustomLoadingIndicatorThemeData({
    this.child,
  });

  ///defines the child for the widget
  final Widget? child;


  /// Creates a copy of this theme but with the given fields 
  /// replaced with the new values.
  @override
  CustomLoadingIndicatorThemeData copyWith({
    Widget? child,
  }) {
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
