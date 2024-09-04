// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:{{{full_path}}}/variables/values/color_values.dart';
import 'package:{{{full_path}}}/variables/values/text_values.dart';

extension ExtendedTextTheme on TextTheme {
  static TextStyle displayTwoExtraLarge(BuildContext context) =>
      GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.display2xl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayExtraLarge(BuildContext context) =>
      GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.displayXl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayLarge(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.displayLg,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayMedium(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.displayMd,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displaySmall(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.displaySm,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle displayExtraSmall(BuildContext context) =>
      GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.displayXs,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textExtraLarge(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.textXl,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textLarge(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.textLg,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textMedium(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.textMd,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textSmall(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.textSm,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );

  static TextStyle textExtraSmall(BuildContext context) => GoogleFonts.{{font_family.lowerCase()}}(
        fontSize: TextValues.textXs,
        fontWeight: TextValues.regular,
        color: ColorValues.textPrimary(context),
      );
}
