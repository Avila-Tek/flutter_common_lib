// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:avilatek_ui/src/ui/selector_button/selector_button_style.dart';
import 'package:flutter/material.dart';

class SelectorButton extends StatelessWidget {
  const SelectorButton({
    required this.title,
    required this.loadingMessage,
    required this.style,
    this.onPressed,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final String loadingMessage;
  final void Function()? onPressed;
  final bool isLoading;
  final SelectorButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).extension<SelectorButtonStyle>();
    final defaultAppTextStyle = Theme.of(context).textTheme;
    final defaultColor = Theme.of(context).colorScheme;

    final textStyle = style?.textStyle ??
        defaultStyle?.textStyle ??
        defaultAppTextStyle.titleMedium!.copyWith(fontWeight: FontWeight.w500);

    final loadingTextStyle = style?.loadingTextStyle ??
        defaultStyle?.loadingTextStyle ??
        defaultAppTextStyle.titleMedium!.copyWith(fontWeight: FontWeight.w500);

    final borderColorStyle =
        style?.borderColor ?? defaultStyle?.borderColor ?? defaultColor.primary;

    final iconColor = style?.iconColor ?? defaultStyle?.iconColor;

    final loadingIconSize =
        style?.loadingIconSize ?? defaultStyle?.loadingIconSize ?? 20;

    final padding = style?.padding ?? defaultStyle?.padding ?? 8.0;

    final defaultRadius =
        style?.defaultRadius ?? defaultStyle?.defaultRadius ?? 5.0;

    final borderSideWidth =
        style?.borderSideWidth ?? defaultStyle?.borderSideWidth ?? 1.5;

    final titleMaxLines =
        style?.titleMaxLines ?? defaultStyle?.titleMaxLines ?? 1;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColorStyle,
          width: borderSideWidth,
        ),
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: isLoading ? borderColorStyle : Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          child: Padding(
            padding: Theme.of(context).inputDecorationTheme.contentPadding ??
                EdgeInsets.all(padding),
            child: DefaultTextStyle(
              style: textStyle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: isLoading
                        ? Text(loadingMessage, style: loadingTextStyle)
                        : Text(
                            title,
                            maxLines: titleMaxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  SizedBox(width: padding),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: iconColor,
                    size: loadingIconSize,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
