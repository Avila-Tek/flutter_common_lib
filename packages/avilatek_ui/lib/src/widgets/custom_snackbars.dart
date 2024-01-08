// // ignore_for_file: comment_references

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:suni_wallet_app/src/constants.dart';

// class _ErrorSnackBar extends AvilaSnackBar {
//   _ErrorSnackBar(
//     BuildContext context, {
//     required Widget content,
//   }) : super(
//           context,
//           title: Text(S.current.failureTitle),
//           leading: const Icon(
//             FontAwesomeIcons.circleExclamation,
//             color: Consts.surfaceWhite,
//             size: 24,
//           ),
//           content: content,
//         );
// }

// class _SuccessSnackBar extends AvilaSnackBar {
//   _SuccessSnackBar(
//     BuildContext context, {
//     required Widget content,
//   }) : super(
//           context,
//           title: Text(S.current.successTitle),
//           leading: const Icon(
//             FontAwesomeIcons.solidCircleCheck,
//             color: Consts.surfaceWhite,
//             size: 24,
//           ),
//           content: content,
//         );
// }

// /// {@template custom_snackbar}
// /// This widget represents a custom [SnackBar] that follows the app's design
// /// language. You should avoid using a [SnackBar] directly, and use this widget
// /// instead.
// ///
// /// This widget has two static methods to create a [SnackBar] with a success or
// /// error message. You should use those when you need to show a success or error
// /// message, instead of creating a [AvilaSnackBar] directly.
// ///
// /// The [title] is the header of the snackbar. It is usually a [Text] widget.
// /// The title [TextStyle] defaults to the app theme's guidelines. You should
// ///
// /// The [content] widget is displayed just below the [title]. It is usually a
// /// [Text] widget with a smaller font size than the [title]. The [content]
// /// also has a default [TextStyle], so you should avoid overriding it.
// ///
// /// The [leading] parameter is an optional widget displayed at the beginning of
// /// the snackbar. It is usually an [Icon].
// /// {@endtemplate}
// class AvilaSnackBar extends SnackBar {
//   /// {@macro custom_snackbar}
//   AvilaSnackBar(
//     BuildContext context, {
//     required Widget title,
//     required Widget content,
//     required Widget? leading,
//     super.key,
//   }) : super(
//           duration: const Duration(seconds: 7),
//           content: Row(
//             children: [
//               if (leading != null) leading,
//               if (leading != null) const SizedBox(width: Consts.padding * 2),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     DefaultTextStyle(
//                       style: context.textTheme.titleSmall!.apply(
//                         color: Consts.surfaceWhite,
//                         fontWeightDelta: 2,
//                         fontSizeDelta: 2,
//                       ),
//                       child: title,
//                     ),
//                     const SizedBox(height: Consts.padding * 0.5),
//                     DefaultTextStyle(
//                       style: context.textTheme.bodyMedium!.merge(
//                         AppTextStyle.custom(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       child: content,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );

//   /// Custom snackbar to show a successful message.
//   /// {@macro custom_snackbar}
//   factory AvilaSnackBar.success(
//     BuildContext context, {
//     required Widget content,
//   }) {
//     return _SuccessSnackBar(
//       context,
//       content: content,
//     );
//   }

//   /// Custom snackbar to show an error message.
//   /// {@macro custom_snackbar}
//   factory AvilaSnackBar.error(
//     BuildContext context, {
//     required Widget content,
//   }) {
//     return _ErrorSnackBar(
//       context,
//       content: content,
//     );
//   }
// }
