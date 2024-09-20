// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:{{{full_path}}}/variables/values/color_values.dart';
import 'package:{{{full_path}}}/variables/values/text_values.dart';

extension ExtendedTextTheme on TextTheme {
  static TextStyle displayTwoExtraLarge(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.display2xl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayExtraLarge(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.displayXl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayLarge(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.displayLg,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayMedium(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.displayMd,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displaySmall(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.displaySm,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayExtraSmall(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.displayXs,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textExtraLarge(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.textXl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textLarge(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.textLg,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textMedium(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.textMd,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textSmall(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.textSm,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textExtraSmall(BuildContext context) =>
      TextValues.fontFamilyStyle(
        fontSize: TextValues.textXs,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );
}
