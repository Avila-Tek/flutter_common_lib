// import 'package:flutter/material.dart';
// import 'package:suni_wallet_app/src/constants.dart';

// /// {@template section}
// /// This widget represents a section in the UI. The pages should be divided into
// /// sections to make the design more consistent. Each section should be
// /// separated by a [Consts.sectionPadding] sized space.
// ///
// /// The [title] is the header of the section. It is usually a [Text] widget.
// /// The title [TextStyle] defaults to the app theme's guidelines. You should
// /// avoid overriding it to keep consistency in the design.
// ///
// /// The [description] widget is displayed just below the [title]. It is usually a
// /// [Text] widget with a smaller font size than the [title]. The [description]
// /// also has a default [TextStyle], so you should avoid overriding it.
// ///
// /// The [trailing] parameter is an optional widget displayed at the end of the
// /// section. It is usually an [TextButton].
// ///
// /// The [body] parameter is the main content. Displayed below the [title] and
// /// [description] widgets. It usually is a [Column] or a [Card], but it can be
// /// any widget.
// ///
// /// The [bottom] parameter is an optional widget displayed at the bottom of the
// /// section. You may use it as a footer.
// /// {@endtemplate}
// class Section extends StatelessWidget {
//   /// {@macro section}
//   const Section({
//     super.key,
//     required this.title,
//     this.titleSpacing = Consts.padding,
//     this.description,
//     this.trailing,
//     this.body,
//     this.bottom,
//   });

//   final Widget title;
//   final Widget? description;
//   final Widget? trailing;
//   final Widget? body;
//   final Widget? bottom;
//   final double? titleSpacing;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DefaultTextStyle(
//                     style: context.textTheme.titleLarge ?? const TextStyle(),
//                     child: title,
//                   ),
//                   if (description != null) ...[
//                     const SizedBox(height: Consts.padding),
//                     DefaultTextStyle(
//                       style: Theme.of(context).textTheme.labelMedium ??
//                           const TextStyle(),
//                       child: description!,
//                     ),
//                   ]
//                 ],
//               ),
//             ),
//             if (trailing != null) ...[
//               const SizedBox(width: Consts.padding),
//               trailing!,
//             ],
//           ],
//         ),
//         SizedBox(height: titleSpacing),
//         if (body != null) body!,
//         if (bottom != null) ...[
//           const SizedBox(height: Consts.padding),
//           bottom!,
//         ]
//       ],
//     );
//   }
// }
