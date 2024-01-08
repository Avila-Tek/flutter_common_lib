// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;
// import 'package:suni_wallet_app/src/constants.dart';

// enum NumericInputType {
//   /// Numeric input with automatic 2-floating point formatting. No decimal
//   /// point button.
//   currency,

//   /// Numeric input with integer formatting. No decimal point button, and no
//   /// decimal point in the input.
//   integer,

//   /// Numeric input with dynamic floating point. Decimal point button, and
//   /// decimal point in the input manually added by the user.
//   dynamicFloatingPoint,
// }

// /// {@template integrated_numeric_pad}
// ///
// /// Numeric keypad widget with optional integrated conversion rate.
// ///
// /// <img src="https://i.imgur.com/mS6DUBa.png" alt="Numeric Pad example" width="250"/>
// ///
// ///
// /// Typically used in views where the user needs to input an amount for a given
// /// transaction.
// ///
// /// This widget required a [TextEditingController] to keep track of the input
// /// value. The [onChanged] callback is an optional callback called whenever the
// /// input value changes.
// ///
// /// The [showConversionRate] parameter defines whether the conversion rate
// /// should be displayed or not. If [showConversionRate] is `true`, both the
// /// [conversionRate] and [conversionCurrencySymbol] parameters must not be null.
// ///
// /// The [initialValue] will be used to initialize the [TextEditingController]
// /// value. This is usefull for use-cases where navigating forth and back resets
// /// the widget's state. To avoid this, you should keep track in the parents
// /// state the value of the input, and set the [initialValue] to that value to
// /// avoid losing it when pushing and poping back to the parent's view.
// /// If [initialValue] is null, the default value will be 0. This
// ///
// /// The [actions] parameter is an optional widget that will be displayed below
// /// the conversion rate (or the amount, if [showConversionRate] is set to false).
// /// You can pass any widget you want here.
// ///
// /// The [inputType] parameter defines the behavior of the input. The default
// /// value is [NumericInputType.currency], and will format the input as a
// /// currency value with 2 decimal digits. You may also use [NumericInputType.integer]
// /// to format the input as an integer value, or [NumericInputType.dynamicFloatingPoint]
// /// to enable the decimal point button and allow the user to input a value with
// /// a dynamic floating point.
// ///
// /// {@endtemplate}
// class NumericPad extends StatefulWidget {
//   /// {@macro integrated_numeric_pad}
//   const NumericPad({
//     super.key,
//     required this.controller,
//     this.onChanged,
//     this.actions,
//     this.inputType = NumericInputType.currency,
//     this.currencySymbol = 'USDC',
//     this.conversionCurrencySymbol = 'SATS',
//     this.conversionCurrencyDecimals = 0,
//     bool? showConversionRate,
//     double? conversionRate,
//     num? initialValue,
//   })  : initialValue = initialValue ?? 0,
//         showConversionRate = showConversionRate ?? false,
//         conversionRate = conversionRate ?? 0;

//   final NumericInputType inputType;
//   final TextEditingController controller;
//   final num initialValue;
//   final int conversionCurrencyDecimals;
//   final Function(num value)? onChanged;
//   final Widget? actions;
//   final bool showConversionRate;
//   final double conversionRate;
//   final String currencySymbol;
//   final String conversionCurrencySymbol;

//   @override
//   State<NumericPad> createState() => _NumericPadState();
// }

// class _NumericPadState extends State<NumericPad> {
//   String get text => widget.controller.text;

//   /// The input value to be shown to the user.
//   num get input {
//     if (widget.inputType == NumericInputType.integer) {
//       return double.tryParse(text)?.toInt() ?? 0;
//     }
//     if (widget.inputType == NumericInputType.currency) {
//       return (double.tryParse(text) ?? 0) / 100;
//     }

//     return num.tryParse(text) ?? 0;
//   }

//   bool get inputHasDecimalPoint => text.contains(getDecimalSeparator());

//   @override
//   void initState() {
//     String initialValue;

//     if (widget.initialValue == 0) {
//       initialValue = '0';
//     } else if (widget.inputType == NumericInputType.currency) {
//       initialValue = (widget.initialValue * 100).toStringAsFixed(0);
//     } else if (widget.inputType == NumericInputType.integer) {
//       initialValue = widget.initialValue.toInt().toString();
//     } else {
//       initialValue = widget.initialValue.toString();
//     }

//     widget.controller.text = initialValue;

//     widget.controller.addListener(() {
//       setState(() {
//         widget.onChanged?.call(input);
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AutoSizeText(
//           widget.inputType == NumericInputType.dynamicFloatingPoint
//               ? '${widget.currencySymbol} $text'
//               : input.formattedToCurrency(
//                   symbol: widget.currencySymbol,
//                   decimalDigits:
//                       widget.inputType == NumericInputType.integer ? 0 : 2,
//                 ),
//           style: context.textTheme.headlineLarge,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: Consts.padding),
//         if (widget.showConversionRate) ...[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.swap_vert,
//                 color: Consts.secondaryOne.shade300,
//                 size: 27,
//               ),
//               const SizedBox(width: Consts.padding * 0.5),
//               Flexible(
//                 child: AutoSizeText(
//                   (widget.conversionRate * input).formattedToCurrency(
//                     symbol: widget.conversionCurrencySymbol,
//                     decimalDigits: widget.conversionCurrencyDecimals,
//                   ),
//                   style: context.textTheme.titleLarge
//                       ?.copyWith(color: Consts.secondaryOne.shade300),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: Consts.padding),
//         ],
//         if (widget.actions != null) ...[
//           const SizedBox(height: Consts.padding),
//           widget.actions!,
//           const SizedBox(height: Consts.padding),
//         ],
//         GridView.count(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           crossAxisCount: 3,
//           childAspectRatio: 2,
//           padding: EdgeInsets.zero,
//           crossAxisSpacing: 0,
//           mainAxisSpacing: 0,
//           children: [
//             _NumericPadButton(
//               child: const Text('1'),
//               onPressed: () {
//                 onKeyPressed('1');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('2'),
//               onPressed: () {
//                 onKeyPressed('2');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('3'),
//               onPressed: () {
//                 onKeyPressed('3');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('4'),
//               onPressed: () {
//                 onKeyPressed('4');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('5'),
//               onPressed: () {
//                 onKeyPressed('5');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('6'),
//               onPressed: () {
//                 onKeyPressed('6');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('7'),
//               onPressed: () {
//                 onKeyPressed('7');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('8'),
//               onPressed: () {
//                 onKeyPressed('8');
//               },
//             ),
//             _NumericPadButton(
//               child: const Text('9'),
//               onPressed: () {
//                 onKeyPressed('9');
//               },
//             ),
//             if (widget.inputType == NumericInputType.dynamicFloatingPoint)
//               _NumericPadButton(
//                 onPressed:
//                     !inputHasDecimalPoint ? () => onKeyPressed('.') : null,
//                 child: Text(getDecimalSeparator()),
//               )
//             else
//               const SizedBox(),
//             _NumericPadButton(
//               child: const Text('0'),
//               onPressed: () {
//                 onKeyPressed('0');
//               },
//             ),
//             _NumericPadButton(
//               child: const Icon(Icons.backspace_outlined),
//               onPressed: () {
//                 onKeyPressed('BS');
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void onKeyPressed(String value) {
//     if (value == '.' && inputHasDecimalPoint) return;

//     if (value == '.' && text.isEmpty) {
//       widget.controller.text = '0.';
//       return;
//     }

//     if (value == 'BS') {
//       widget.controller.text = text.substring(0, text.length - 1);

//       if (widget.controller.text.isEmpty) {
//         widget.controller.text = '0';
//       }
//       return;
//     }

//     if (value != '.' && text == '0') {
//       widget.controller.text = value;
//       return;
//     }

//     widget.controller.text += value;
//   }

//   String getCurrentLocale() {
//     final locale = PlatformDispatcher.instance.locale;

//     return locale.languageCode;
//   }

//   String getDecimalSeparator() {
//     final locale = getCurrentLocale();

//     return numberFormatSymbols[locale]?.DECIMAL_SEP ?? '.';
//   }
// }

// class _NumericPadButton extends StatelessWidget {
//   const _NumericPadButton({required this.child, this.onPressed});

//   final Widget child;

//   final Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     final color = onPressed != null ? Consts.fontBlack : Consts.neutral;
//     const size = 34.0;

//     return Theme(
//       data: ThemeData(
//         iconTheme: IconThemeData(
//           color: color,
//           size: size - 4,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           child: Center(
//             child: DefaultTextStyle(
//               style: GoogleFonts.quicksand(
//                 fontSize: size,
//                 color: color,
//                 fontWeight: FontWeight.w600,
//               ),
//               child: child,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NumbericPadDialog {
//   static Future<num?> show(
//     BuildContext context, {
//     TextEditingController? controller,
//     dynamic Function(num)? onChanged,
//     Widget? actions,
//     NumericInputType inputType = NumericInputType.currency,
//     String currencySymbol = 'USDC',
//     String conversionCurrencySymbol = 'SATS',
//     int conversionCurrencyDecimals = 0,
//     bool? showConversionRate,
//     double? conversionRate,
//     num? initialValue,
//     required String title,
//   }) {
//     final dialogController = controller ?? TextEditingController();
//     return showModalBottomSheet<num>(
//       isScrollControlled: true,
//       showDragHandle: true,
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 title,
//                 style: AppTextStyle.custom(
//                   fontSize: 20,
//                   color: Consts.fontBlack,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Gap(Consts.margin),
//               NumericPad(
//                 inputType: inputType,
//                 controller: dialogController,
//                 onChanged: onChanged,
//                 actions: actions,
//                 currencySymbol: currencySymbol,
//                 conversionCurrencySymbol: conversionCurrencySymbol,
//                 conversionCurrencyDecimals: conversionCurrencyDecimals,
//                 conversionRate: conversionRate,
//                 initialValue: initialValue,
//                 showConversionRate: showConversionRate,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
