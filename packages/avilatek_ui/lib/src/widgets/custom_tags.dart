import 'package:avilatek_ui/src/ui/custom_tag/custom_tag_style.dart';
import 'package:flutter/material.dart';

/// {@template custom_tag}
/// This widget displays a tag. Usually used for status indicators.
///
/// This class has custom constructors for the most common colors.
///
/// Parameters
/// ---
/// The [child] parameter is the main content of the tag. It is usually a [Text]
/// widget.
///
/// {@endtemplate}
class CustomTag extends StatelessWidget {
  /// {@macro custom_tag}
  const CustomTag({
    required this.child,
    required this.style,
    super.key,
  });

  /// Custom constructor for a tag with the primary color of the app.
  /// The [child] parameter is the main content of the tag. It is usually a
  /// [Text] widget.
  /// The [context] parameter is used to get the primary color of the app.
  /// The [style] parameter is used if you want to override the default style
  /// for this constructor.
  factory CustomTag.primaryOne(
    BuildContext context, {
    required Widget child,
    CustomTagStyle? style,
  }) {
    final themeStyle = Theme.of(context).extension<CustomTagStyle>();

    final primaryColor = Theme.of(context).primaryColor;

    final backgroundColor =
        style?.backgroundColor ?? primaryColor.withOpacity(0.3);

    final foregroundColor = style?.foregroundColor ?? primaryColor;

    final iconColor = style?.iconColor ?? primaryColor;

    final padding = style?.padding ?? themeStyle?.padding;

    final border = style?.border ?? themeStyle?.border;

    final textStyle = style?.textStyle ?? themeStyle?.textStyle;

    return CustomTag(
      style: CustomTagStyle(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        border: border,
        iconColor: iconColor,
        textStyle: textStyle,
      ),
      child: child,
    );
  }

  /// Custom constructor for a tag with green color. Use this constructor
  /// when you want to display a tag with a success color.
  /// The [child] parameter is the main content of the tag. It is usually a
  /// [Text] widget.
  /// The [context] parameter is used to get the default CustomTagStyle.
  /// The [style] parameter is used if you want to override the default style
  /// for this constructor.
  factory CustomTag.green(
    BuildContext context, {
    required Widget child,
    CustomTagStyle? style,
  }) {
    final themeStyle = Theme.of(context).extension<CustomTagStyle>();

    final green = Colors.green[800];

    final backgroundColor = style?.backgroundColor ?? green?.withOpacity(0.3);

    final foregroundColor = style?.foregroundColor ?? green;

    final iconColor = style?.iconColor ?? green;

    final padding = style?.padding ?? themeStyle?.padding;

    final border = style?.border ?? themeStyle?.border;

    final textStyle = style?.textStyle ?? themeStyle?.textStyle;

    return CustomTag(
      style: CustomTagStyle(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        border: border,
        iconColor: iconColor,
        textStyle: textStyle,
      ),
      child: child,
    );
  }

  /// Custom constructor for a tag with green color. Use this constructor
  /// when you want to display a tag with a warning color.
  /// The [child] parameter is the main content of the tag. It is usually a
  /// [Text] widget.
  /// The [context] parameter is used to get the default CustomTagStyle.
  /// The [style] parameter is used if you want to override the default style
  /// for this constructor.
  factory CustomTag.yellow(
    BuildContext context, {
    required Widget child,
    CustomTagStyle? style,
  }) {
    final themeStyle = Theme.of(context).extension<CustomTagStyle>();

    final yellow = Colors.yellow[800];

    final backgroundColor = style?.backgroundColor ?? yellow?.withOpacity(0.3);

    final foregroundColor = style?.foregroundColor ?? yellow;

    final iconColor = style?.iconColor ?? yellow;

    final padding = style?.padding ?? themeStyle?.padding;

    final border = style?.border ?? themeStyle?.border;

    final textStyle = style?.textStyle ?? themeStyle?.textStyle;

    return CustomTag(
      style: CustomTagStyle(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        border: border,
        iconColor: iconColor,
        textStyle: textStyle,
      ),
      child: child,
    );
  }

  /// Custom constructor for a tag with green color. Use this constructor
  /// when you want to display a tag with a danger color.
  /// The [child] parameter is the main content of the tag. It is usually a
  /// [Text] widget.
  /// The [context] parameter is used to get the default CustomTagStyle.
  /// The [style] parameter is used if you want to override the default style
  /// for this constructor.
  factory CustomTag.red(
    BuildContext context, {
    required Widget child,
    CustomTagStyle? style,
  }) {
    final themeStyle = Theme.of(context).extension<CustomTagStyle>();

    final red = Colors.red[800];

    final backgroundColor = style?.backgroundColor ?? red?.withOpacity(0.3);

    final foregroundColor = style?.foregroundColor ?? red;

    final iconColor = style?.iconColor ?? red;

    final padding = style?.padding ?? themeStyle?.padding;

    final border = style?.border ?? themeStyle?.border;

    final textStyle = style?.textStyle ?? themeStyle?.textStyle;

    return CustomTag(
      style: CustomTagStyle(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        border: border,
        iconColor: iconColor,
        textStyle: textStyle,
      ),
      child: child,
    );
  }

  /// Custom constructor for a tag with the grey color. Use this constructor
  /// when you want to display a tag with a neutral color.
  /// The [child] parameter is the main content of the tag. It is usually a
  /// [Text] widget.
  /// The [context] parameter is used to get the default CustomTagStyle.
  /// The [style] parameter is used if you want to override the default style
  /// for this constructor.
  factory CustomTag.grey(
    BuildContext context, {
    required Widget child,
    CustomTagStyle? style,
  }) {
    final themeStyle = Theme.of(context).extension<CustomTagStyle>();

    final grey = Colors.grey.shade800;

    final backgroundColor = style?.backgroundColor ?? grey.withOpacity(0.3);

    final foregroundColor = style?.foregroundColor ?? grey;

    final iconColor = style?.iconColor ?? grey;

    final padding = style?.padding ?? themeStyle?.padding;

    final border = style?.border ?? themeStyle?.border;

    final textStyle = style?.textStyle ?? themeStyle?.textStyle;

    return CustomTag(
      style: CustomTagStyle(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        border: border,
        iconColor: iconColor,
        textStyle: textStyle,
      ),
      child: child,
    );
  }

  ///
  final Widget child;

  ///
  final CustomTagStyle? style;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).extension<CustomTagStyle>();

    final defaultTheme = Theme.of(context);

    final textStyle = style?.textStyle ??
        defaultStyle?.textStyle ??
        defaultTheme.textTheme.labelMedium;

    final backgroundColor =
        style?.backgroundColor ?? defaultStyle?.backgroundColor;

    final foregroundColor =
        style?.foregroundColor ?? defaultStyle?.foregroundColor;

    final iconColor =
        style?.iconColor ?? defaultStyle?.iconColor ?? foregroundColor;

    final iconSize = style?.iconSize ?? defaultStyle?.iconSize ?? 15.0;

    final padding = style?.padding ?? defaultStyle?.padding;

    final border = style?.border ?? defaultStyle?.border;

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(
          color: iconColor ?? foregroundColor,
          size: iconSize,
        ),
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          border: border,
        ),
        child: DefaultTextStyle(
          style: textStyle!.copyWith(
            color: foregroundColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
