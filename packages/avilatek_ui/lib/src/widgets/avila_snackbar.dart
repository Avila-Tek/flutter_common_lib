// ignore_for_file: overridden_fields, lines_longer_than_80_chars, comment_references

import 'package:avilatek_ui/src/ui/avila_snackbar/avila_snackbar.dart';
import 'package:flutter/material.dart';

/// `_snackBarDisplayDuration` is used to handle the duration of the `SnackBar`
const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);

/// `AvilaSnackBar` class is being used to handle the `SnackBar` with `Avila` theme
/// for `success`, `failure`, `info` and `warning` snackbar types
/// and also for the default snackbar
///
/// `AvilaSnackBar` extends `SnackBar`
class AvilaSnackBar extends SnackBar {
  /// `AvilaSnackBar` constructor
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

  /// `success` method is used to create a `SnackBar` with `success` theme
  /// and also with the provided `content` and `context`
  ///
  /// **Returns**
  ///
  /// `SnackBar` with `success` theme
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
    /// `themeStyle` is used to get the current `AvilaSnackBarTheme` from the `context`
    /// and also to get the `successThemeData` from the `AvilaSnackBarTheme`
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    /// `snackBarBackgroundColor` is used to get the `backgroundColor` for the `SnackBar`
    final snackBarBackgroundColor = backgroundColor ??
        style?.successThemeData?.backgroundColor ??
        themeStyle?.successThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.success.color;

    /// `snackBarElevation` is used to get the `elevation` for the `SnackBar`
    final snackBarElevation = elevation ??
        style?.successThemeData?.elevation ??
        themeStyle?.successThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    /// `snackBarShape` is used to get the `shape` for the `SnackBar`
    final snackBarShape = shape ??
        style?.successThemeData?.shape ??
        themeStyle?.successThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    /// `snackBarBehavior` is used to get the `behavior` for the `SnackBar`
    final snackBarBehavior = behavior ??
        style?.successThemeData?.behavior ??
        themeStyle?.successThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    /// `snackBarShowCloseIcon` is used to get the `showCloseIcon` for the `SnackBar`
    final snackBarShowCloseIcon = showCloseIcon ??
        style?.successThemeData?.showCloseIcon ??
        themeStyle?.successThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    /// `snackBarCloseIconColor` is used to get the `closeIconColor` for the `SnackBar`
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

  /// `failure` method is used to create a `SnackBar` with `failure` theme
  /// and also with the provided `content` and `context`
  ///
  /// **Returns**
  ///
  /// `SnackBar` with `failure` theme
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
    /// `themeStyle` is used to get the current `AvilaSnackBarTheme` from the `context`
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    /// `snackBarBackgroundColor` is used to get the `backgroundColor` for the `SnackBar`
    final snackBarBackgroundColor = backgroundColor ??
        style?.failureThemeData?.backgroundColor ??
        themeStyle?.failureThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.failure.color;

    /// `snackBarElevation` is used to get the `elevation` for the `SnackBar`
    final snackBarElevation = elevation ??
        style?.failureThemeData?.elevation ??
        themeStyle?.failureThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    /// `snackBarShape` is used to get the `shape` for the `SnackBar`
    final snackBarShape = shape ??
        style?.failureThemeData?.shape ??
        themeStyle?.failureThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    /// `snackBarBehavior` is used to get the `behavior` for the `SnackBar`
    final snackBarBehavior = behavior ??
        style?.failureThemeData?.behavior ??
        themeStyle?.failureThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    /// `snackBarShowCloseIcon` is used to get the `showCloseIcon` for the `SnackBar`
    final snackBarShowCloseIcon = showCloseIcon ??
        style?.failureThemeData?.showCloseIcon ??
        themeStyle?.failureThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    /// `snackBarCloseIconColor` is used to get the `closeIconColor` for the `SnackBar`
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

  /// `warning` method is used to create a `SnackBar` with `warning` theme
  /// and also with the provided `content` and `context`
  ///
  /// **Returns**
  ///
  /// `SnackBar` with `warning` theme
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
    /// `themeStyle` is used to get the current `AvilaSnackBarTheme` from the `context`
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    /// `snackBarBackgroundColor` is used to get the `backgroundColor` for the `SnackBar`
    final snackBarBackgroundColor = backgroundColor ??
        style?.warningThemeData?.backgroundColor ??
        themeStyle?.warningThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.warning.color;

    /// `snackBarElevation` is used to get the `elevation` for the `SnackBar`
    final snackBarElevation = elevation ??
        style?.warningThemeData?.elevation ??
        themeStyle?.warningThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    /// `snackBarShape` is used to get the `shape` for the `SnackBar`
    final snackBarShape = shape ??
        style?.warningThemeData?.shape ??
        themeStyle?.warningThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    /// `snackBarBehavior` is used to get the `behavior` for the `SnackBar`
    final snackBarBehavior = behavior ??
        style?.warningThemeData?.behavior ??
        themeStyle?.warningThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    /// `snackBarShowCloseIcon` is used to get the `showCloseIcon` for the `SnackBar`
    final snackBarShowCloseIcon = showCloseIcon ??
        style?.warningThemeData?.showCloseIcon ??
        themeStyle?.warningThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    /// `snackBarCloseIconColor` is used to get the `closeIconColor` for the `SnackBar`
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

  /// `info` method is used to create a `SnackBar` with `info` theme
  /// and also with the provided `content` and `context`
  ///
  /// **Returns**
  ///
  /// `SnackBar` with `info` theme
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
    /// `themeStyle` is used to get the current `AvilaSnackBarTheme` from the `context`
    final themeStyle = Theme.of(context).extension<AvilaSnackBarTheme>();

    /// `snackBarBackgroundColor` is used to get the `backgroundColor` for the `SnackBar`
    final snackBarBackgroundColor = backgroundColor ??
        style?.infoThemeData?.backgroundColor ??
        themeStyle?.infoThemeData?.backgroundColor ??
        themeStyle?.defaultThemeData?.backgroundColor ??
        AvilaSnackBarContentType.info.color;

    /// `snackBarElevation` is used to get the `elevation` for the `SnackBar`
    final snackBarElevation = elevation ??
        style?.infoThemeData?.elevation ??
        themeStyle?.infoThemeData?.elevation ??
        themeStyle?.defaultThemeData?.elevation ??
        0;

    /// `snackBarShape` is used to get the `shape` for the `SnackBar`
    final snackBarShape = shape ??
        style?.infoThemeData?.shape ??
        themeStyle?.infoThemeData?.shape ??
        themeStyle?.defaultThemeData?.shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        );

    /// `snackBarBehavior` is used to get the `behavior` for the `SnackBar`
    final snackBarBehavior = behavior ??
        style?.infoThemeData?.behavior ??
        themeStyle?.infoThemeData?.behavior ??
        themeStyle?.defaultThemeData?.behavior ??
        SnackBarBehavior.fixed;

    /// `snackBarShowCloseIcon` is used to get the `showCloseIcon` for the `SnackBar`
    final snackBarShowCloseIcon = showCloseIcon ??
        style?.infoThemeData?.showCloseIcon ??
        themeStyle?.infoThemeData?.showCloseIcon ??
        themeStyle?.defaultThemeData?.showCloseIcon ??
        false;

    /// `snackBarCloseIconColor` is used to get the `closeIconColor` for the `SnackBar`
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

  /// Widget to place as content.
  ///
  /// This is the main content of the snackbar.
  ///
  /// This is the only required parameter.
  @override
  final Widget content;

  /// The color of the snackbar.
  ///
  /// If null, the color is determined by the [SnackBarThemeData.backgroundColor]
  /// of the current [SnackBarTheme], which is usually dependent on the [ThemeData.colorScheme].
  @override
  final Color? backgroundColor;

  /// The z-coordinate at which to place the snackbar.
  ///
  /// This controls the size of the shadow below the snackbar.
  ///
  /// If this is non-zero, the contents of the snackbar are clipped by this shadow.
  ///
  /// If this property is null, then [SnackBarThemeData.elevation] of the current [SnackBarTheme] is used.
  @override
  final double? elevation;

  /// The amount of space by which to inset the snackbar.
  ///
  /// The empty space that surrounds the snack bar.
  ///
  /// If this property is null, then [SnackBarThemeData.margin] of the current [SnackBarTheme] is used.
  @override
  final EdgeInsetsGeometry? margin;

  /// The amount of space by which to inset the snackbar's [content].
  ///
  /// The empty space that surrounds the snack bar's [content].
  ///
  /// If this property is null, then [SnackBarThemeData.padding] of the current [SnackBarTheme] is used.
  @override
  final EdgeInsetsGeometry? padding;

  /// The width of the snackbar.
  ///
  /// If non-null, the snack bar will be forced to have this width.
  ///
  /// If null, the snack bar will take up the full width of its parent.
  @override
  final double? width;

  /// The shape of the snackbar's [Material].
  ///
  /// If the shape is a [RoundedRectangleBorder], then the corners are
  /// rounded by [kBorderRadius] which is 4.0 pixels.
  ///
  /// If this property is null, then [SnackBarThemeData.shape] of the current [SnackBarTheme] is used.
  @override
  final ShapeBorder? shape;

  /// How this snackbar should behave when a user taps the screen.
  ///
  /// Defines the behavior of the snackbar when it is visible and the user taps the screen.
  ///
  /// If this property is null, then [SnackBarThemeData.behavior] of the current [SnackBarTheme] is used.
  final HitTestBehavior? hitTestBehavior;

  /// How this snackbar should behave when a user taps the screen.
  ///
  /// Defines the behavior of the snackbar when it is visible and the user taps the screen.
  ///
  /// If this property is null, then [SnackBarThemeData.behavior] of the current [SnackBarTheme] is used.
  @override
  final SnackBarBehavior? behavior;

  /// The action that the user can take based on the snack bar.
  ///
  /// The action will be placed below the [content] and above the [closeButton].
  ///
  /// If this property is null, then no action button will be placed in the snackbar.
  @override
  final SnackBarAction? action;

  /// The threshold for displaying the action button.
  ///
  /// If the width of the snackbar is bigger than this value, the action button will be displayed.
  ///
  /// If this property is null, then [SnackBarThemeData.actionOverflowThreshold]
  /// of the current [SnackBarTheme] is used.
  @override
  final double? actionOverflowThreshold;

  /// Whether to show the close button.
  ///
  /// If this property is null, then [SnackBarThemeData.showCloseIcon]
  /// of the current [SnackBarTheme] is used.
  ///
  /// If this property is true, the close button will be displayed.
  ///
  /// If this property is false, the close button will not be displayed.
  @override
  final bool? showCloseIcon;

  /// The color of the close button.
  ///
  /// If this property is null, then [SnackBarThemeData.closeIconColor]
  /// of the current [SnackBarTheme] is used.
  @override
  final Color? closeIconColor;

  /// The amount of time the snackbar should be displayed.
  @override
  final Duration duration;

  /// The animation driving the entrance and exit of the snack bar.
  ///
  /// If this property is null, then [SnackBarThemeData.animation]
  /// of the current [SnackBarTheme] is used.
  @override
  final Animation<double>? animation;

  /// Called when the snack bar is visible.
  ///
  /// If this property is null, then [SnackBarThemeData.onVisible]
  /// of the current [SnackBarTheme] is used.
  @override
  final VoidCallback? onVisible;

  /// The direction in which the snackbar can be dismissed.
  ///
  /// If this property is null, then [SnackBarThemeData.dismissDirection]
  /// of the current [SnackBarTheme] is used.
  @override
  final DismissDirection dismissDirection;

  /// The behavior of the snackbar's [Material] and its children.
  ///
  /// If this property is null, then [SnackBarThemeData.clipBehavior]
  /// of the current [SnackBarTheme] is used.
  @override
  final Clip clipBehavior;

  /// The style of the [AvilaSnackBar] widget.
  ///
  /// If this property is null, then [SnackBarThemeData.style]
  /// of the current [SnackBarTheme] is used.
  final AvilaSnackBarTheme? style;

  /// `show` method is used to show the snackbar
  /// with the provided `content` and `context`
  /// and also with the provided `style`
  ///
  /// Also, clears the previous snackbar if any
  /// and shows the new snackbar
  Future<void> show(BuildContext context) async {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(this);
  }
}
