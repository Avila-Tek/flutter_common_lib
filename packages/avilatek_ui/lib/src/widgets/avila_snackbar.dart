// import 'package:awesome_snackbar_content/src/assets_path.dart';
// import 'package:awesome_snackbar_content/src/content_type.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:ui' as ui;

// class AvilaSnackbar extends StatelessWidget {

//   const AvilaSnackbar({
//     required this.title, required this.message, required this.contentType, super.key,
//     this.color,
//     this.titleFontSize,
//     this.messageFontSize,
//     this.inMaterialBanner = false,
//   });
//   /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
//   /// backgroundColor: Colors.transparent
//   /// behavior: SnackBarBehavior.floating
//   /// elevation: 0.0

//   /// /// `IMPORTANT NOTE` for MaterialBanner properties before putting this in `content`
//   /// backgroundColor: Colors.transparent
//   /// forceActionsBelow: true,
//   /// elevation: 0.0
//   /// [inMaterialBanner = true]

//   /// title is the header String that will show on top
//   final String title;

//   /// message String is the body message which shows only 2 lines at max
//   final String message;

//   /// `optional` color of the SnackBar/MaterialBanner body
//   final Color? color;

//   /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
//   final ContentType contentType;

//   /// if you want to use this in materialBanner
//   final bool inMaterialBanner;

//   /// if you want to customize the font size of the title
//   final double? titleFontSize;

//   /// if you want to customize the font size of the message
//   final double? messageFontSize;

//   @override
//   Widget build(BuildContext context) {
//     final var isRTL = Directionality.of(context) == TextDirection.rtl;

//     final size = MediaQuery.of(context).size;

//     // screen dimensions
//     final var isMobile = size.width <= 768;
//     final var isTablet = size.width > 768 && size.width <= 992;

//     /// for reflecting different color shades in the SnackBar
//     final hsl = HSLColor.fromColor(color ?? contentType.color!);
//     final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

//     var horizontalPadding = 0;
//     var leftSpace = size.width * 0.12;
//     final var rightSpace = size.width * 0.12;

//     if (isMobile) {
//       horizontalPadding = size.width * 0.01;
//     } else if (isTablet) {
//       leftSpace = size.width * 0.05;
//       horizontalPadding = size.width * 0.2;
//     } else {
//       leftSpace = size.width * 0.05;
//       horizontalPadding = size.width * 0.3;
//     }

//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: horizontalPadding,
//       ),
//       height: size.height * 0.125,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topCenter,
//         children: [
//           /// background container
//           Container(
//             width: size.width,
//             decoration: BoxDecoration(
//               color: color ?? contentType.color,
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),

//           /// Splash SVG asset
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//               ),
//               child: SvgPicture.asset(
//                 AssetsPath.bubbles,
//                 height: size.height * 0.06,
//                 width: size.width * 0.05,
//                 colorFilter:
//                     _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
//                 package: 'awesome_snackbar_content',
//               ),
//             ),
//           ),

//           // Bubble Icon
//           Positioned(
//             top: -size.height * 0.02,
//             left: !isRTL
//                 ? leftSpace -
//                     8 -
//                     (isMobile ? size.width * 0.075 : size.width * 0.035)
//                 : null,
//             right: isRTL
//                 ? rightSpace -
//                     8 -
//                     (isMobile ? size.width * 0.075 : size.width * 0.035)
//                 : null,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SvgPicture.asset(
//                   AssetsPath.back,
//                   height: size.height * 0.06,
//                   colorFilter:
//                       _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
//                   package: 'awesome_snackbar_content',
//                 ),
//                 Positioned(
//                   top: size.height * 0.015,
//                   child: SvgPicture.asset(
//                     assetSVG(contentType),
//                     height: size.height * 0.022,
//                     package: 'awesome_snackbar_content',
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// content
//           Positioned.fill(
//             left: isRTL ? size.width * 0.03 : leftSpace,
//             right: isRTL ? rightSpace : size.width * 0.03,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     /// `title` parameter
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: titleFontSize ??
//                               (!isMobile
//                                   ? size.height * 0.03
//                                   : size.height * 0.025),
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),

//                     InkWell(
//                       onTap: () {
//                         if (inMaterialBanner) {
//                           ScaffoldMessenger.of(context)
//                               .hideCurrentMaterialBanner();
//                           return;
//                         }
//                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                       },
//                       child: SvgPicture.asset(
//                         AssetsPath.failure,
//                         height: size.height * 0.022,
//                         package: 'awesome_snackbar_content',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: size.height * 0.005,
//                 ),

//                 /// `message` body text parameter
//                 Expanded(
//                   child: Text(
//                     message,
//                     style: TextStyle(
//                       fontSize: messageFontSize ?? size.height * 0.016,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.015,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Reflecting proper icon based on the contentType
//   String assetSVG(ContentType contentType) {
//     switch (contentType) {
//       case ContentType.failure:

//         /// failure will show `CROSS`
//         return AssetsPath.failure;
//       case ContentType.success:

//         /// success will show `CHECK`
//         return AssetsPath.success;
//       case ContentType.warning:

//         /// warning will show `EXCLAMATION`
//         return AssetsPath.warning;
//       case ContentType.help:

//         /// help will show `QUESTION MARK`
//         return AssetsPath.help;
//       default:
//         return AssetsPath.failure;
//     }
//   }

//   static ColorFilter? _getColorFilter(
//           ui.Color? color, ui.BlendMode colorBlendMode,) =>
//       color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
// }



// // // ignore_for_file: comment_references

// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:suni_wallet_app/src/constants.dart';

// // class _ErrorSnackBar extends AvilaSnackBar {
// //   _ErrorSnackBar(
// //     BuildContext context, {
// //     required Widget content,
// //   }) : super(
// //           context,
// //           title: Text(S.current.failureTitle),
// //           leading: const Icon(
// //             FontAwesomeIcons.circleExclamation,
// //             color: Consts.surfaceWhite,
// //             size: 24,
// //           ),
// //           content: content,
// //         );
// // }

// // class _SuccessSnackBar extends AvilaSnackBar {
// //   _SuccessSnackBar(
// //     BuildContext context, {
// //     required Widget content,
// //   }) : super(
// //           context,
// //           title: Text(S.current.successTitle),
// //           leading: const Icon(
// //             FontAwesomeIcons.solidCircleCheck,
// //             color: Consts.surfaceWhite,
// //             size: 24,
// //           ),
// //           content: content,
// //         );
// // }

// // /// {@template custom_snackbar}
// // /// This widget represents a custom [SnackBar] that follows the app's design
// // /// language. You should avoid using a [SnackBar] directly, and use this widget
// // /// instead.
// // ///
// // /// This widget has two static methods to create a [SnackBar] with a success or
// // /// error message. You should use those when you need to show a success or error
// // /// message, instead of creating a [AvilaSnackBar] directly.
// // ///
// // /// The [title] is the header of the snackbar. It is usually a [Text] widget.
// // /// The title [TextStyle] defaults to the app theme's guidelines. You should
// // ///
// // /// The [content] widget is displayed just below the [title]. It is usually a
// // /// [Text] widget with a smaller font size than the [title]. The [content]
// // /// also has a default [TextStyle], so you should avoid overriding it.
// // ///
// // /// The [leading] parameter is an optional widget displayed at the beginning of
// // /// the snackbar. It is usually an [Icon].
// // /// {@endtemplate}
// // class AvilaSnackBar extends SnackBar {
// //   /// {@macro custom_snackbar}
// //   AvilaSnackBar(
// //     BuildContext context, {
// //     required Widget title,
// //     required Widget content,
// //     required Widget? leading,
// //     super.key,
// //   }) : super(
// //           duration: const Duration(seconds: 7),
// //           content: Row(
// //             children: [
// //               if (leading != null) leading,
// //               if (leading != null) const SizedBox(width: Consts.padding * 2),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     DefaultTextStyle(
// //                       style: context.textTheme.titleSmall!.apply(
// //                         color: Consts.surfaceWhite,
// //                         fontWeightDelta: 2,
// //                         fontSizeDelta: 2,
// //                       ),
// //                       child: title,
// //                     ),
// //                     const SizedBox(height: Consts.padding * 0.5),
// //                     DefaultTextStyle(
// //                       style: context.textTheme.bodyMedium!.merge(
// //                         AppTextStyle.custom(
// //                           color: Colors.white,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                       child: content,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );

// //   /// Custom snackbar to show a successful message.
// //   /// {@macro custom_snackbar}
// //   factory AvilaSnackBar.success(
// //     BuildContext context, {
// //     required Widget content,
// //   }) {
// //     return _SuccessSnackBar(
// //       context,
// //       content: content,
// //     );
// //   }

// //   /// Custom snackbar to show an error message.
// //   /// {@macro custom_snackbar}
// //   factory AvilaSnackBar.error(
// //     BuildContext context, {
// //     required Widget content,
// //   }) {
// //     return _ErrorSnackBar(
// //       context,
// //       content: content,
// //     );
// //   }
// // }
