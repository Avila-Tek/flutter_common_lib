// ignore_for_file: overridden_fields

import 'package:avilatek_ui/src/ui/avila_snackbar/avila_snackbar.dart';
import 'package:flutter/material.dart';

const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);

class AvilaSnackBar extends SnackBar {
  const AvilaSnackBar({
    required this.content,
    super.key,
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
    this.style,
  }) : super(
          content: content,
          backgroundColor: backgroundColor,
          elevation: elevation,
          margin: margin,
          padding: padding,
          width: width,
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

  factory AvilaSnackBar.success({
    required BuildContext context,
    required Widget content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    double? actionOverflowThreshold,
    bool? showCloseIcon,
    Color? closeIconColor,
    Duration? duration,
    Animation<double>? animation,
    VoidCallback? onVisible,
    DismissDirection? dismissDirection,
    Clip? clipBehavior,
    AvilaSnackBarTheme? style,
  }) {
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    final snackBarBackgroundColor = backgroundColor ??
        style?.successThemeData?.backgroundColor ??
        themeStyle?.successThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.success.color;

    final snackBarElevation = elevation ??
        style?.successThemeData?.elevation ??
        themeStyle?.successThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    final snackBarShape = shape ??
        style?.successThemeData?.shape ??
        themeStyle?.successThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    final snackBarBehavior = behavior ??
        style?.successThemeData?.behavior ??
        themeStyle?.successThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    final snackBarShowCloseIcon = showCloseIcon ??
        style?.successThemeData?.showCloseIcon ??
        themeStyle?.successThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    final snackBarCloseIconColor = closeIconColor ??
        style?.successThemeData?.closeIconColor ??
        themeStyle?.successThemeData?.closeIconColor ??
        themeStyle?.defaultThemeData?.closeIconColor ??
        Colors.white;

    return AvilaSnackBar(
      content: content,
      backgroundColor: snackBarBackgroundColor,
      elevation: snackBarElevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: snackBarShape,
      hitTestBehavior: hitTestBehavior,
      behavior: snackBarBehavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: snackBarShowCloseIcon,
      closeIconColor: snackBarCloseIconColor,
      duration: duration ?? _snackBarDisplayDuration,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection ?? DismissDirection.down,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
    );
  }

  factory AvilaSnackBar.failure({
    required BuildContext context,
    required Widget content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    double? actionOverflowThreshold,
    bool? showCloseIcon,
    Color? closeIconColor,
    Duration? duration,
    Animation<double>? animation,
    VoidCallback? onVisible,
    DismissDirection? dismissDirection,
    Clip? clipBehavior,
    AvilaSnackBarTheme? style,
  }) {
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    final snackBarBackgroundColor = backgroundColor ??
        style?.failureThemeData?.backgroundColor ??
        themeStyle?.failureThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.failure.color;

    final snackBarElevation = elevation ??
        style?.failureThemeData?.elevation ??
        themeStyle?.failureThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    final snackBarShape = shape ??
        style?.failureThemeData?.shape ??
        themeStyle?.failureThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    final snackBarBehavior = behavior ??
        style?.failureThemeData?.behavior ??
        themeStyle?.failureThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    final snackBarShowCloseIcon = showCloseIcon ??
        style?.failureThemeData?.showCloseIcon ??
        themeStyle?.failureThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    final snackBarCloseIconColor = closeIconColor ??
        style?.failureThemeData?.closeIconColor ??
        themeStyle?.failureThemeData?.closeIconColor ??
        themeStyle?.defaultThemeData?.closeIconColor ??
        Colors.white;

    return AvilaSnackBar(
      content: content,
      backgroundColor: snackBarBackgroundColor,
      elevation: snackBarElevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: snackBarShape,
      hitTestBehavior: hitTestBehavior,
      behavior: snackBarBehavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: snackBarShowCloseIcon,
      closeIconColor: snackBarCloseIconColor,
      duration: duration ?? _snackBarDisplayDuration,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection ?? DismissDirection.down,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
    );
  }

  factory AvilaSnackBar.warning({
    required BuildContext context,
    required Widget content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    double? actionOverflowThreshold,
    bool? showCloseIcon,
    Color? closeIconColor,
    Duration? duration,
    Animation<double>? animation,
    VoidCallback? onVisible,
    DismissDirection? dismissDirection,
    Clip? clipBehavior,
    AvilaSnackBarTheme? style,
  }) {
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    final snackBarBackgroundColor = backgroundColor ??
        style?.warningThemeData?.backgroundColor ??
        themeStyle?.warningThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.warning.color;

    final snackBarElevation = elevation ??
        style?.warningThemeData?.elevation ??
        themeStyle?.warningThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    final snackBarShape = shape ??
        style?.warningThemeData?.shape ??
        themeStyle?.warningThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    final snackBarBehavior = behavior ??
        style?.warningThemeData?.behavior ??
        themeStyle?.warningThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    final snackBarShowCloseIcon = showCloseIcon ??
        style?.warningThemeData?.showCloseIcon ??
        themeStyle?.warningThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    final snackBarCloseIconColor = closeIconColor ??
        style?.warningThemeData?.closeIconColor ??
        themeStyle?.warningThemeData?.closeIconColor ??
        themeStyle?.defaultThemeData?.closeIconColor ??
        Colors.white;

    return AvilaSnackBar(
      content: content,
      backgroundColor: snackBarBackgroundColor,
      elevation: snackBarElevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: snackBarShape,
      hitTestBehavior: hitTestBehavior,
      behavior: snackBarBehavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: snackBarShowCloseIcon,
      closeIconColor: snackBarCloseIconColor,
      duration: duration ?? _snackBarDisplayDuration,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection ?? DismissDirection.down,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
    );
  }

  factory AvilaSnackBar.info({
    required BuildContext context,
    required Widget content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    double? actionOverflowThreshold,
    bool? showCloseIcon,
    Color? closeIconColor,
    Duration? duration,
    Animation<double>? animation,
    VoidCallback? onVisible,
    DismissDirection? dismissDirection,
    Clip? clipBehavior,
    AvilaSnackBarTheme? style,
  }) {
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    final snackBarBackgroundColor = backgroundColor ??
        style?.infoThemeData?.backgroundColor ??
        themeStyle?.infoThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.info.color;

    final snackBarElevation = elevation ??
        style?.infoThemeData?.elevation ??
        themeStyle?.infoThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    final snackBarShape = shape ??
        style?.infoThemeData?.shape ??
        themeStyle?.infoThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    final snackBarBehavior = behavior ??
        style?.infoThemeData?.behavior ??
        themeStyle?.infoThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    final snackBarShowCloseIcon = showCloseIcon ??
        style?.infoThemeData?.showCloseIcon ??
        themeStyle?.infoThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    final snackBarCloseIconColor = closeIconColor ??
        style?.infoThemeData?.closeIconColor ??
        themeStyle?.infoThemeData?.closeIconColor ??
        themeStyle?.defaultThemeData?.closeIconColor ??
        Colors.white;

    return AvilaSnackBar(
      content: content,
      backgroundColor: snackBarBackgroundColor,
      elevation: snackBarElevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: snackBarShape,
      hitTestBehavior: hitTestBehavior,
      behavior: snackBarBehavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: snackBarShowCloseIcon,
      closeIconColor: snackBarCloseIconColor,
      duration: duration ?? _snackBarDisplayDuration,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection ?? DismissDirection.down,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
    );
  }

  @override
  final Widget content;

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

  final AvilaSnackBarTheme? style;

  Future<void> show(BuildContext context) async {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(this);
  }
}
