import 'package:avilatek_ui/src/ui/custom_tag/custom_tag_style.dart';
import 'package:avilatek_ui/src/ui/custom_tag/custom_tag_theme.dart';
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
  factory CustomTag.primary(
    BuildContext context, {
    required Widget child,
  }) {
    final primaryTagTheme =
        Theme.of(context).extension<CustomTagTheme>()?.primaryStyle;

    final primaryColor = Theme.of(context).primaryColor;

    final backgroundColor =
        primaryTagTheme?.backgroundColor ?? primaryColor.withOpacity(0.1);

    final foregroundColor = primaryTagTheme?.foregroundColor ?? primaryColor;

    final iconColor = primaryTagTheme?.iconColor ?? primaryColor;

    final padding = primaryTagTheme?.padding;

    final border = primaryTagTheme?.border;

    final textStyle = primaryTagTheme?.textStyle;

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
  /// The [context] parameter is used to get the green CustomTagStyle.
  factory CustomTag.green(
    BuildContext context, {
    required Widget child,
  }) {
    final themeGreenTagStyle =
        Theme.of(context).extension<CustomTagTheme>()?.greenStyle;

    const defaultGreenColor = Colors.green;

    final backgroundColor =
        themeGreenTagStyle?.backgroundColor ?? defaultGreenColor.shade100;

    final foregroundColor =
        themeGreenTagStyle?.foregroundColor ?? defaultGreenColor.shade800;

    final iconColor =
        themeGreenTagStyle?.iconColor ?? defaultGreenColor.shade800;

    final padding = themeGreenTagStyle?.padding;

    final border = themeGreenTagStyle?.border;

    final textStyle = themeGreenTagStyle?.textStyle;

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
  /// The [context] parameter is used to get the yellow CustomTagStyle.
  factory CustomTag.yellow(
    BuildContext context, {
    required Widget child,
  }) {
    final themeYellowTagStyle =
        Theme.of(context).extension<CustomTagTheme>()?.yellowStyle;

    const defaultYellowColor = Colors.yellow;

    final backgroundColor =
        themeYellowTagStyle?.backgroundColor ?? defaultYellowColor.shade100;

    final foregroundColor =
        themeYellowTagStyle?.foregroundColor ?? defaultYellowColor.shade800;

    final iconColor =
        themeYellowTagStyle?.iconColor ?? defaultYellowColor.shade800;

    final padding = themeYellowTagStyle?.padding;

    final border = themeYellowTagStyle?.border;

    final textStyle = themeYellowTagStyle?.textStyle;

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
  /// The [context] parameter is used to get the red CustomTagStyle.
  factory CustomTag.red(
    BuildContext context, {
    required Widget child,
  }) {
    final themeRedTagStyle =
        Theme.of(context).extension<CustomTagTheme>()?.redStyle;

    const defaultRedColor = Colors.red;

    final backgroundColor =
        themeRedTagStyle?.backgroundColor ?? defaultRedColor.shade100;

    final foregroundColor =
        themeRedTagStyle?.foregroundColor ?? defaultRedColor.shade800;

    final iconColor = themeRedTagStyle?.iconColor ?? defaultRedColor.shade800;

    final padding = themeRedTagStyle?.padding;

    final border = themeRedTagStyle?.border;

    final textStyle = themeRedTagStyle?.textStyle;

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
  /// The [context] parameter is used to get the neutral CustomTagStyle.
  factory CustomTag.grey(
    BuildContext context, {
    required Widget child,
  }) {
    final themeRedTagStyle =
        Theme.of(context).extension<CustomTagTheme>()?.neutralStyle;

    const defaultGreyColor = Colors.grey;

    final backgroundColor =
        themeRedTagStyle?.backgroundColor ?? defaultGreyColor.shade300;

    final foregroundColor =
        themeRedTagStyle?.foregroundColor ?? defaultGreyColor.shade800;

    final iconColor = themeRedTagStyle?.iconColor ?? defaultGreyColor.shade800;

    final padding = themeRedTagStyle?.padding;

    final border = themeRedTagStyle?.border;

    final textStyle = themeRedTagStyle?.textStyle;

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

  /// The main content of the tag. It is usually a [Text] widget.
  final Widget child;

  /// The style of the tag.
  final CustomTagStyle? style;

  @override
  Widget build(BuildContext context) {
    final defaultTagTheme =
        Theme.of(context).extension<CustomTagTheme>()?.defaultStyle;

    final defaultTheme = Theme.of(context);

    final textStyle = style?.textStyle ??
        defaultTagTheme?.textStyle ??
        defaultTheme.textTheme.labelMedium;

    final backgroundColor =
        style?.backgroundColor ?? defaultTagTheme?.backgroundColor;

    final foregroundColor =
        style?.foregroundColor ?? defaultTagTheme?.foregroundColor;

    final iconColor =
        style?.iconColor ?? defaultTagTheme?.iconColor ?? foregroundColor;

    final iconSize = style?.iconSize ?? defaultTagTheme?.iconSize ?? 15.0;

    final padding = style?.padding ??
        defaultTagTheme?.padding ??
        const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        );

    final border = style?.border ?? defaultTagTheme?.border;

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
