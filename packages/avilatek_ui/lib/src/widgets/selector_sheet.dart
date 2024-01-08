import 'package:avilatek_ui/src/ui/avila_theme.dart';
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
    super.key,
  });

  /// The title of the sheet displayed in the view's [AppBar]
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
    return Scaffold(
      appBar: AppBar(title: title),
      body: ListView.separated(
        padding: padding ?? AvilaTheme.of(context).margins,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Material(
            color: Colors.transparent,
            clipBehavior: Clip.hardEdge,
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
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}
