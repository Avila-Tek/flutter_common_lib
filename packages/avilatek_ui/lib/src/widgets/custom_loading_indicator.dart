// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/material.dart';

/// A custom loading indicator that displays a child widget
/// or a platform-specific loading indicator.
class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.child,
  });

  /// The child widget to display.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    ///Best null operator ever
    ///This allows for easy future modification of the return widget. (You're welcome)
    return child ?? const CircularProgressIndicator.adaptive();
  }
}
