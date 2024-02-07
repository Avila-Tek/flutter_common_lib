import 'package:avilatek_ui/src/ui/title_wrapper.dart/title_wrapper_style.dart';
import 'package:flutter/material.dart';

/// {@template custom_text_field}
/// A custom widget with a title. This widget should be the preferred option
/// for displaying text fields, dropdowns, and other widget in
/// the app, as it provides a consistent look and feel.
///
///
/// [title] is usually a [Text] widget. By default, the style of the
/// title is [TitleWrapperStyle.titleStyle] and should not be
/// overriden, unless necessary.
///
/// [child] is the widget that will be displayed below the title, usually
/// a [TextField], [TextFormField] or [DropdownButton].
/// {@endtemplate}
class TitleWrapper extends StatelessWidget {
  /// {@macro custom_text_field}
  const TitleWrapper({
    required this.child,
    required this.title,
    this.footer,
    this.style,
    super.key,
  });

  /// Widget to place as title.
  final Widget title;

  /// The widget that will be displayed below the title. Usually a [TextField],
  /// [TextFormField] or [DropdownButton].
  final Widget child;

  /// A widget that will be displayed below the [child]. Usually a [Text] widget
  /// with additional context.
  final Widget? footer;

  /// The style of the [TitleWrapper] widget.
  final TitleWrapperStyle? style;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).extension<TitleWrapperStyle>();
    final defaultAppTextStyle = Theme.of(context).textTheme;

    final titleStyle = style?.titleStyle ??
        defaultStyle?.titleStyle ??
        defaultAppTextStyle.titleMedium;

    final titleSpacing =
        style?.titleSpacing ?? defaultStyle?.titleSpacing ?? 20.0;

    final footerStyle = style?.footerStyle ??
        defaultStyle?.footerStyle ??
        defaultAppTextStyle.bodyMedium;

    final footerSpacing =
        style?.footerSpacing ?? defaultStyle?.footerSpacing ?? 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: titleStyle!,
          child: title,
        ),
        SizedBox(
          height: titleSpacing,
        ),
        child,
        if (footer != null) ...[
          SizedBox(
            height: footerSpacing,
          ),
          DefaultTextStyle(
            style: footerStyle!,
            child: footer!,
          ),
        ],
      ],
    );
  }
}
