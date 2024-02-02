import 'dart:ui' as ui;

import 'package:avilatek_ui/src/ui/avila_snackbar/avila_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvilaSnackBarContent extends StatelessWidget {
  const AvilaSnackBarContent({
    required this.title,
    required this.message,
    required this.contentType,
    super.key,
    this.color,
    this.titleFontSize,
    this.messageFontSize,
    this.inMaterialBanner = false,
    this.padding,
    this.height,
    this.width,
    this.margin,
  });

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// `optional` color of the SnackBar/MaterialBanner body
  final Color? color;

  /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
  final AvilaSnackBarContentType contentType;

  /// if you want to use this in materialBanner
  final bool inMaterialBanner;

  /// if you want to customize the font size of the title
  final double? titleFontSize;

  /// if you want to customize the font size of the message
  final double? messageFontSize;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final double? height;

  final double? width;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).extension<AvilaSnackBarStyle>();
    final defaultAppTextStyle = Theme.of(context).textTheme;

    final isRTL = Directionality.of(context) == TextDirection.rtl;

    final size = MediaQuery.of(context).size;

    // screen dimensions
    final isMobile = size.width <= 768;
    final isTablet = size.width > 768 && size.width <= 992;

    /// for reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    var horizontalPadding = 0.0;
    var leftSpace = size.width * 0.12;
    final rightSpace = size.width * 0.12;

    if (isMobile) {
      horizontalPadding = size.width * 0.01;
    } else if (isTablet) {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.2;
    } else {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.3;
    }

    return Container(
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
      height: height ?? size.height * 0.125,
      child: Stack(
        clipBehavior: Clip.none, //TODO
        alignment: Alignment.topCenter, //TODO
        children: [
          /// background container
          Container(
            width: width ?? size.width,
            decoration: BoxDecoration(
              color: color ?? contentType.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          /// Splash SVG asset
          //TODO
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                AvilaSnackBarAssetsPath.bubbles,
                height: size.height * 0.06,
                width: size.width * 0.05,
                colorFilter:
                    _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
                package: 'avilatek_ui',
              ),
            ),
          ),

          //TODO
          // Bubble Icon
          Positioned(
            top: -size.height * 0.02,
            left: !isRTL
                ? leftSpace -
                    8 -
                    (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            right: isRTL
                ? rightSpace -
                    8 -
                    (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AvilaSnackBarAssetsPath.back,
                  height: size.height * 0.06,
                  colorFilter:
                      _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
                  package: 'avilatek_ui',
                ),
                Positioned(
                  top: size.height * 0.015,
                  child: SvgPicture.asset(
                    assetSVG(contentType),
                    height: size.height * 0.022,
                    package: 'avilatek_ui',
                  ),
                ),
              ],
            ),
          ),

          /// content
          Positioned.fill(
            left: isRTL ? size.width * 0.03 : leftSpace,
            right: isRTL ? rightSpace : size.width * 0.03,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// `title` parameter
                    Expanded(
                      flex: 3,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: titleFontSize ??
                              (!isMobile
                                  ? size.height * 0.03
                                  : size.height * 0.025),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        if (inMaterialBanner) {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                          return;
                        }
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      child: SvgPicture.asset(
                        AvilaSnackBarAssetsPath.failure,
                        height: size.height * 0.022,
                        package: 'avilatek_ui',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),

                /// `message` body text parameter
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: messageFontSize ?? size.height * 0.016,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(AvilaSnackBarContentType contentType) {
    switch (contentType) {
      case AvilaSnackBarContentType.failure:

        /// failure will show `CROSS`
        return AvilaSnackBarAssetsPath.failure;
      case AvilaSnackBarContentType.success:

        /// success will show `CHECK`
        return AvilaSnackBarAssetsPath.success;
      case AvilaSnackBarContentType.warning:

        /// warning will show `EXCLAMATION`
        return AvilaSnackBarAssetsPath.warning;
      case AvilaSnackBarContentType.help:

        /// help will show `QUESTION MARK`
        return AvilaSnackBarAssetsPath.help;
      default:
        return AvilaSnackBarAssetsPath.failure;
    }
  }

  static ColorFilter? _getColorFilter(
    ui.Color? color,
    ui.BlendMode colorBlendMode,
  ) =>
      color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
}
