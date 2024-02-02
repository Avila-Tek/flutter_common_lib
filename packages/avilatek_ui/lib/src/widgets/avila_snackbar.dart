import 'package:avilatek_ui/src/ui/avila_snackbar/avila_snackbar.dart';
import 'package:flutter/material.dart';

const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);

class AvilaSnackBar extends SnackBar {
  AvilaSnackBar({
    required this.title,
    required this.message,
    required this.contentType,
    super.key,
    this.titleFontSize,
    this.messageFontSize,
    this.inMaterialBanner = false,
    this.content,
    this.backgroundColor,
    this.elevation,
    this.margin,
    this.padding,
    this.width,
    this.shape,
    this.hitTestBehavior,
    this.behavior,
    this.action,
    this.actionOverflowThreshold,
    this.showCloseIcon,
    this.closeIconColor,
    this.duration = _snackBarDisplayDuration,
    this.animation,
    this.onVisible,
    this.dismissDirection = DismissDirection.down,
    this.clipBehavior = Clip.hardEdge,
    this.contentColor,
    this.height,
  }) : super(
          content: content ??
              AvilaSnackBarContent(
                title: title,
                message: message,
                contentType: contentType,
                color: contentColor,
                titleFontSize: titleFontSize,
                messageFontSize: messageFontSize,
                inMaterialBanner: inMaterialBanner,
                height: height,
                width: width,
                padding: padding,
                margin: margin,
              ),
          backgroundColor: backgroundColor,
          elevation: elevation,
          // margin: margin, //TODO
          // padding: padding,
          // width: width,
          shape: shape,
          behavior: behavior,
          action: action,
          actionOverflowThreshold: actionOverflowThreshold,
          duration: duration,
          animation: animation,
          onVisible: onVisible,
          dismissDirection: dismissDirection,
          clipBehavior: clipBehavior,
        );

  final String title;
  final String message;
  final AvilaSnackBarContentType contentType;
  final bool inMaterialBanner;
  final double? titleFontSize;
  final double? messageFontSize;
  @override
  final Widget? content;
  @override
  final Color? backgroundColor;
  @override
  final double? elevation;
  @override
  final EdgeInsetsGeometry? margin;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final double? width;
  @override
  final ShapeBorder? shape;
  @override
  final HitTestBehavior? hitTestBehavior;
  @override
  final SnackBarBehavior? behavior;
  @override
  final SnackBarAction? action;
  @override
  final double? actionOverflowThreshold;
  @override
  final bool? showCloseIcon;
  @override
  final Color? closeIconColor;
  @override
  final Duration duration;
  @override
  final Animation<double>? animation;
  @override
  final VoidCallback? onVisible;
  @override
  final DismissDirection dismissDirection;
  @override
  final Clip clipBehavior;

  final Color? contentColor;

  final double? height;
}
