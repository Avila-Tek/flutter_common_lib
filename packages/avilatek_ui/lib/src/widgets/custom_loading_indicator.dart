// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/material.dart';

/// [CustomLoadinIndicatorStyle] defines the style of an adaptive dialog action.
class CustomLoadinIndicatorStyle {
  const CustomLoadinIndicatorStyle({
    this.color,
    this.strokeWidth = 4.0,
  });

  /// The color of the loadingindicator.
  final Color? color;

  /// The stroke width of the loadingindicator.
  final double strokeWidth;
}

/// A custom loading indicator that displays a child widget
/// or a platform-specific loading indicator.
class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.child,
    this.style,
  });

  /// The child widget to display.
  final Widget? child;

  /// The style for the loading indicator.
  final CustomLoadinIndicatorStyle? style;

  @override
  Widget build(BuildContext context) {
    ///Best null operator ever
    ///This allows for easy future modification of the return widget. (You're welcome)
    return child ?? const CircularProgressIndicator.adaptive();
  }
}
