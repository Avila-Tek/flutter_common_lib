// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:suni_wallet_app/src/constants.dart';

// /// {@template custom_tag}
// /// This widget displays a tag. Usually used for status indicators.
// ///
// /// This class has custom constructors for the most common colors.
// ///
// /// ![](https://i.imgur.com/hIW3akM.png)
// /// ##### *Example of a [CustomTag.green] widget with a row of [Icon] and [Text] as a child.*
// ///
// /// Parameters
// /// ---
// /// The [child] parameter is the main content of the tag. It is usually a [Text]
// /// widget.
// ///
// /// The [backgroundColor] parameter is the background color of the tag.
// ///
// /// The [foregroundColor] parameter changes the color of the [child] widget.
// ///
// /// The [border] parameter is the border of the tag. It defaults to `null`.
// ///
// /// The optional [padding] parameter overrides the default padding for [CustomTag].
// ///
// /// The [iconColor] parameter changes the color of the [Icon] widget.
// ///
// /// {@endtemplate}
// class CustomTag extends StatelessWidget {
//   /// {@macro custom_tag}
//   const CustomTag({
//     super.key,
//     required this.child,
//     required this.backgroundColor,
//     required this.foregroundColor,
//     this.border,
//     this.padding,
//     this.iconColor,
//   });

//   final Widget child;
//   final BoxBorder? border;
//   final EdgeInsets? padding;
//   final Color? iconColor;
//   final Color backgroundColor;
//   final Color foregroundColor;

//   factory CustomTag.primaryOne({
//     required Widget child,
//     EdgeInsets? padding,
//   }) {
//     return CustomTag(
//       border: Border.all(
//         color: Consts.primaryOne.shade200,
//         width: 1,
//       ),
//       backgroundColor: Consts.primaryOne.shade50,
//       foregroundColor: Consts.primaryOne.shade500,
//       iconColor: Consts.primaryOne.shade500,
//       padding: padding,
//       child: child,
//     );
//   }

//   factory CustomTag.primaryTwo({
//     required Widget child,
//     EdgeInsets? padding,
//   }) {
//     return CustomTag(
//       border: Border.all(
//         color: Consts.primaryTwo.shade200,
//         width: 1,
//       ),
//       backgroundColor: Consts.primaryTwo.shade50,
//       foregroundColor: Consts.primaryTwo.shade700,
//       iconColor: Consts.primaryTwo.shade500,
//       padding: padding,
//       child: child,
//     );
//   }

//   factory CustomTag.grey({
//     required Widget child,
//     EdgeInsets? padding,
//   }) {
//     return CustomTag(
//       border: Border.all(
//         color: Consts.neutral.shade200,
//         width: 1,
//       ),
//       backgroundColor: Consts.neutral.shade50,
//       foregroundColor: Consts.neutral.shade400,
//       iconColor: Consts.neutral.shade500,
//       padding: padding,
//       child: child,
//     );
//   }

//   factory CustomTag.green({
//     required Widget child,
//     EdgeInsets? padding,
//   }) {
//     return CustomTag(
//       border: Border.all(
//         color: Consts.success.shade200,
//         width: 1,
//       ),
//       backgroundColor: Consts.success.shade50,
//       foregroundColor: Consts.success.shade700,
//       iconColor: Consts.success.shade500,
//       padding: padding,
//       child: child,
//     );
//   }

//   factory CustomTag.yellow({
//     required Widget child,
//     EdgeInsets? padding,
//   }) {
//     return CustomTag(
//       border: Border.all(
//         color: Consts.warning.shade200,
//         width: 1,
//       ),
//       backgroundColor: Consts.warning.shade50,
//       foregroundColor: Consts.warning.shade700,
//       iconColor: Consts.warning.shade500,
//       padding: padding,
//       child: child,
//     );
//   }

//   factory CustomTag.red({
//     required Widget child,
//     EdgeInsets? padding,
//   }) {
//     return CustomTag(
//       border: Border.all(
//         color: Consts.error.shade200,
//         width: 1,
//       ),
//       backgroundColor: Consts.error.shade50,
//       foregroundColor: Consts.error.shade700,
//       iconColor: Consts.error.shade500,
//       padding: padding,
//       child: child,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         iconTheme: IconThemeData(
//           color: iconColor ?? foregroundColor,
//           size: 15,
//         ),
//       ),
//       child: Container(
//         padding: padding ??
//             const EdgeInsets.symmetric(
//               horizontal: Consts.padding * 1,
//               vertical: Consts.padding * 0.5,
//             ),
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(100),
//           border: border,
//         ),
//         child: DefaultTextStyle(
//           style: GoogleFonts.quicksand(
//             color: foregroundColor,
//             fontSize: 13,
//             fontWeight: FontWeight.w700,
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
