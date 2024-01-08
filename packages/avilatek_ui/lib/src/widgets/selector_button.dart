// import 'package:flutter/material.dart';
// import 'package:suni_wallet_app/src/constants.dart';

// class SelectorButton extends StatelessWidget {
//   const SelectorButton({
//     required this.title,
//     this.onPressed,
//     this.isLoading = false,
//     super.key,
//   });

//   final String title;
//   final void Function()? onPressed;
//   final bool isLoading;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         side: const BorderSide(
//           color: Consts.inputBorderColor,
//           width: 1.5,
//         ),
//         borderRadius: BorderRadius.circular(Consts.defaultRadius),
//       ),
//       clipBehavior: Clip.hardEdge,
//       child: Material(
//         color: isLoading
//             ? Consts.inputBorderColor.withOpacity(0.15)
//             : Colors.transparent,
//         child: InkWell(
//           onTap: isLoading ? null : onPressed,
//           child: Padding(
//             padding: Theme.of(context).inputDecorationTheme.contentPadding ??
//                 const EdgeInsets.all(Consts.padding),
//             child: DefaultTextStyle(
//               style: context.textTheme.titleMedium!.merge(
//                 AppTextStyle.custom(fontWeight: FontWeight.w500),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: isLoading
//                         ? Text(
//                             S.of(context).loadingMessage,
//                             style: AppTextStyle.custom(
//                               color: Consts.inputBorderColor,
//                             ),
//                           )
//                         : Text(
//                             title,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                   ),
//                   const SizedBox(width: Consts.padding),
//                   const Icon(
//                     Icons.keyboard_arrow_down_outlined,
//                     color: Consts.neutral,
//                     size: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
