import 'package:avilatek_ui/src/ui/avila_theme.dart';
import 'package:avilatek_ui/src/ui/widget_with_title/widget_with_title_theme.dart';
import 'package:flutter/material.dart';

/// {@template custom_text_field}
/// A custom widget with a title. This widget should be the preferred option
/// for displaying text fields, dropdowns, and other widget in
/// the app, as it provides a consistent look and feel.
///
///
/// [title] is usually a [Text] widget. By default, the style of the
/// title is [AvilaThemeData.fieldWithTitleTheme.titleStyle] and should not be
/// overriden, unless necessary.
///
/// [child] is the widget that will be displayed below the title, usually
/// a [TextField], [TextFormField] or [DropdownButton].
/// {@endtemplate}
class WidgetWithTitle extends StatelessWidget {
  /// {@macro custom_text_field}
  const WidgetWithTitle({
    required this.child,
    this.titleText,
    this.title,
    this.footer,
    this.style,
    super.key,
  }) : assert(
          !(title != null && titleText != null),
          'Declaring both title and titleText is not supported.',
        );

  /// Optional text to place as title.
  ///
  /// If a more elaborate title is required, consider using [title] instead.
  ///
  /// Only one of [title] and [titleText] can be specified.
  final String? titleText;

  /// Optional widget to place as title.
  ///
  /// Only one of [title] and [titleText] can be specified.
  final Widget? title;

  /// The widget that will be displayed below the title. Usually a [TextField],
  /// [TextFormField] or [DropdownButton].
  final Widget child;

  /// A widget that will be displayed below the [child]. Usually a [Text] widget
  /// with additional context.
  final Widget? footer;

  /// The style of the [WidgetWithTitle] widget.
  final WidgetWithTitleThemeData? style;

  @override
  Widget build(BuildContext context) {
    final titleWidget = title ?? Text(titleText!);

    return Padding(
      padding:
          AvilaTheme.of(context).fieldWithTitleTheme.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: style?.titleStyle ??
                AvilaTheme.of(context).fieldWithTitleTheme.titleStyle!,
            child: titleWidget,
          ),
          SizedBox(
            height: style?.titleSpacing ??
                AvilaTheme.of(context).fieldWithTitleTheme.titleSpacing,
          ),
          child,
          if (footer != null) ...[
            SizedBox(
              height: style?.footerSpacing ??
                  AvilaTheme.of(context).fieldWithTitleTheme.footerSpacing,
            ),
            DefaultTextStyle(
              style: style?.footerStyle ??
                  AvilaTheme.of(context).fieldWithTitleTheme.footerStyle!,
              child: footer!,
            ),
          ],
        ],
      ),
    );
  }
}
