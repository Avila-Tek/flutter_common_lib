import 'package:flutter/material.dart';

/// {@template custom_text_field}
/// A custom field with a title. This widget should be the preferred option
/// for displaying text fields, dropdowns, and other single-input selectors in
/// the app, as it provides a consistent look and feel.
///
///
/// [title] is usually a [Text] widget. By default, the style of the
/// title is [ThemeData.textTheme.titleSmall] and should not be overriden,
/// unless necessary.
///
/// [child] is the widget that will be displayed below the title, usually
/// a [TextField], [TextFormField] or [DropdownButton].
/// {@endtemplate}
class FieldWithTitle extends StatelessWidget {
  /// {@macro custom_text_field}
  const FieldWithTitle({
    required this.title,
    required this.child,
    this.titleSpacing,
    this.footerSpacing,
    this.footer,
    super.key,
  });

  /// The title of the field.
  final Widget title;

  /// The widget that will be displayed below the title. Usually a [TextField],
  /// [TextFormField] or [DropdownButton].
  final Widget child;

  /// A widget that will be displayed below the [child]. Usually a [Text] widget
  /// with additional context.
  final Widget? footer;

  /// The spacing between the title and the [child].
  final double? titleSpacing;

  /// The spacing between the [child] and the [footer].
  final double? footerSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.titleSmall ?? const TextStyle(),
          child: title,
        ),
        SizedBox(height: titleSpacing ?? 0),
        child,
        if (footer != null) ...[
          SizedBox(height: footerSpacing ?? 0),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.labelMedium ?? const TextStyle(),
            child: footer!,
          ),
        ],
      ],
    );
  }
}
