// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:suni_wallet_app/src/constants.dart';

// /// {@template selectable_card}
// /// An special type of [Card] that can be selected, following the app's design
// /// language.
// ///
// /// The [content] is the main widget of the card. Usually a [Text] widget. The
// /// [content]'s [TextStyle] defaults to the guidelines for the main text of
// /// selectable cards. You should avoid overriding it to keep consistency in the
// /// design, except for additional widgets apart from the main text.
// ///
// /// The [isSelected] parameter is a boolean that indicates whether the card is
// /// selected or not. If it is selected, the card's design changes to indicate
// /// that it is selected.
// ///
// /// The [onPressed] parameter is a callback that is called when the card is
// /// pressed.
// ///
// /// {@endtemplate}
// class SelectableCard extends StatelessWidget {
//   const SelectableCard({
//     super.key,
//     required this.content,
//     required this.isSelected,
//     required this.onPressed,
//     this.padding,
//   });

//   final Function() onPressed;
//   final Widget content;
//   final bool isSelected;
//   final EdgeInsetsGeometry? padding;

//   static Widget loading() {
//     return Card(
//       color: Consts.neutral.shade50,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           color: Consts.neutral.shade100,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(Consts.defaultRadius),
//       ),
//       elevation: 2,
//       clipBehavior: Clip.hardEdge,
//     )
//         .animate(
//           delay: 400.ms,
//           onComplete: (controller) => controller.repeat(),
//         )
//         .shimmer(
//           duration: 1500.ms,
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final backgroundColor =
//         isSelected ? Consts.primaryOne.shade50 : Consts.surfaceWhite;
//     final foregroundColor = isSelected
//         ? Consts.secondaryOne.shade900
//         : Consts.secondaryOne.shade500;
//     final borderColor =
//         isSelected ? Consts.primaryOne.shade500 : Consts.neutral.shade200;

//     return Card(
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           color: borderColor,
//           width: isSelected ? 2 : 0.5,
//         ),
//         borderRadius: BorderRadius.circular(Consts.defaultRadius),
//       ),
//       color: backgroundColor,
//       elevation: 2,
//       clipBehavior: Clip.hardEdge,
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           child: Padding(
//             padding: padding ?? const EdgeInsets.all(Consts.margin),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: DefaultTextStyle(
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: foregroundColor,
//                     ),
//                     child: content,
//                   ),
//                 ),
//                 const Gap(Consts.padding),
//                 Radio(
//                   value: isSelected,
//                   groupValue: true,
//                   onChanged: (_) => onPressed,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
