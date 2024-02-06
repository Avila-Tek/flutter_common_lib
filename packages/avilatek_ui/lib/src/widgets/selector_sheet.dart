// ignore_for_file: lines_longer_than_80_chars

import 'package:avilatek_ui/src/ui/selector_sheet/selector_sheet_theme.dart';
import 'package:flutter/material.dart';

/// {@template selector_sheet_item}
/// A [SelectorSheetItem] is a single item that can be selected in a
/// [SelectorSheet].
/// {@endtemplate}
class SelectorSheetItem<T> {
  /// {@macro selector_sheet_item}
  const SelectorSheetItem({
    required this.title,
    required this.value,
    this.subtitle,
  });

  /// The title of the item.
  final Widget? title;

  /// The subtitle of the item displayed below the title.
  final Widget? subtitle;

  /// The value of the item that will be returned when the item is selected.
  final T value;
}

/// {@template selector_sheet}
/// A [SelectorSheet] is a [Scaffold] view with a list of [SelectorSheetItem]
/// items that can be used to select a value from a list of options.
///
/// The [SelectorSheet] is usually used to display an extended list of options
/// that can be selected by the user, that may be too long to be displayed in a
/// [DropdownButton] or list of [RadioListTile] widgets.
///
/// The [SelectorSheet] is must be displayed as a new [MaterialPageRoute] and
/// returns the selected value on pop.
///
/// You can use the [SelectorSheet.show] static method to display the sheet.
///
/// {@endtemplate}
class SelectorSheet<T> extends StatelessWidget {
  /// {@macro selector_sheet}
  const SelectorSheet({
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.padding,
    this.onSelected,
    this.popOnSelected = true,
    this.separator,
    this.appBar,
    this.style,
    super.key,
  });

  /// The title of the sheet displayed in the view's [AppBar] if
  /// [appBar] is not provided.
  final Widget title;

  /// The items that will be displayed in the sheet
  final List<SelectorSheetItem<T>> items;

  /// The builder that will be used to build each item in the list.
  final Widget Function(BuildContext, SelectorSheetItem<T>) itemBuilder;

  /// The padding of the view.
  final EdgeInsets? padding;

  /// Optional callback to be called when an item is selected.
  final void Function(T value)? onSelected;

  /// Whether the sheet should be automatically popped when an item is selected.
  ///
  /// If `true`, the sheet will be popped when an item is selected, even if the
  /// [onSelected] callback is provided. Defaults to `true`.
  final bool popOnSelected;

  /// The separator that will be displayed between each item in the list.
  ///
  /// If not provided, a [Divider] will be used.
  final Widget? separator;

  /// The [AppBar] of the sheet.
  ///
  /// If not provided, a default [AppBar] will be used with the [title].
  final AppBar? appBar;

  /// The style of the sheet.
  ///
  /// If not provided, the default [SelectorSheetTheme] will be used.
  final SelectorSheetTheme? style;

  /// Shows a [SelectorSheet] as a new fullscreen [MaterialPageRoute], and
  /// returns the selected value
  static Future<T?> show<T>(
    BuildContext context,
    SelectorSheet<T> child,
  ) async {
    final selection = await Navigator.of(context).push(
      MaterialPageRoute<T>(
        builder: (_) => child,
        fullscreenDialog: true,
      ),
    );

    return selection;
  }

  @override
  Widget build(BuildContext context) {
    /// Get the [SelectorSheetTheme] from the [style] or the [Theme] of the
    /// context.
    final themeStyle = Theme.of(context).extension<SelectorSheetTheme>();

    /// Get the  `padding` from the [style] or the [Theme] of the context.
    final selectorSheetPadding = padding ??
        style?.selectorSheetThemeData?.padding ??
        themeStyle?.selectorSheetThemeData?.padding ??
        const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        );

    /// Get the `backgroundColor` from the [style] or the [Theme] of the context.
    final selectorSheetBackgroundColor =
        style?.selectorSheetThemeData?.backgroundColor ??
            themeStyle?.selectorSheetThemeData?.backgroundColor ??
            Colors.white;

    /// Get the `itemBackgroundColor` from the [style] or the [Theme] of the context.
    final itemBackgroundColor =
        style?.selectorSheetItemThemeData?.backgroundColor ??
            themeStyle?.selectorSheetItemThemeData?.backgroundColor ??
            Colors.transparent;

    /// Get the `itemClipBehavior` from the [style] or the [Theme] of the context.
    final itemClipBehavior = style?.selectorSheetItemThemeData?.clipBehavior ??
        themeStyle?.selectorSheetItemThemeData?.clipBehavior ??
        Clip.hardEdge;

    /// Get the `itemElevation` from the [style] or the [Theme] of the context.
    final itemElevation = style?.selectorSheetItemThemeData?.elevation ??
        themeStyle?.selectorSheetItemThemeData?.elevation ??
        0;

    /// Get the `itemShape` from the [style] or the [Theme] of the context.
    final itemShape = style?.selectorSheetItemThemeData?.shape ??
        themeStyle?.selectorSheetItemThemeData?.shape ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

    /// Get the `itemShadowColor` from the [style] or the [Theme] of the context.
    final itemShadowColor = style?.selectorSheetItemThemeData?.shadowColor ??
        themeStyle?.selectorSheetItemThemeData?.shadowColor ??
        Colors.transparent;

    return Scaffold(
      backgroundColor: selectorSheetBackgroundColor,
      appBar: appBar ?? AppBar(title: title),
      body: ListView.separated(
        padding: selectorSheetPadding,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Material(
            elevation: itemElevation,
            shape: itemShape,
            shadowColor: itemShadowColor,
            color: itemBackgroundColor,
            clipBehavior: itemClipBehavior,
            child: InkWell(
              onTap: () {
                onSelected?.call(item.value);
                if (popOnSelected) {
                  Navigator.of(context).pop(item.value);
                }
              },
              child: itemBuilder(context, item),
            ),
          );
        },
        separatorBuilder: (_, __) => separator ?? const Divider(),
      ),
    );
  }
}
