// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [DevelopedByLogo] is a widget that displays the logo of the company
/// The logo can be displayed in different styles:
/// [flat, primaryGreen, primaryWhite, and outlined.]
class DevelopedByLogo {
  ///Constructor
  DevelopedByLogo({
    this.size = 15,
    this.alignment = MainAxisAlignment.center,
  });

  ///the size for the component (includes the text and the logo size)
  final double? size;

  ///the alignment for the component
  final MainAxisAlignment alignment;

  /// Returns the flat style of the logo.
  Widget flat({Color? color}) {
    return _buildLogo('packages/avilatek_ui/assets/avilatek_ui/developed_by/flat.svg', color, color ?? Colors.black);
  }

  /// Returns the primaryGreen style of the logo.
  Widget primaryGreen() {
    return _buildLogo(
      'packages/avilatek_ui/assets/avilatek_ui/developed_by/primary_Green.svg',
      null,
      const Color(0xFF135738),
    );
  }

  /// Returns the primaryWhite style of the logo.
  Widget primaryWhite() {
    return _buildLogo('packages/avilatek_ui/assets/avilatek_ui/developed_by/primary_White.svg', null, Colors.white);
  }

  /// Returns the outlined style of the logo.
  Widget outlined({Color? color}) {
    return _buildLogo('packages/avilatek_ui/assets/avilatek_ui/developed_by/outlined.svg',color, color ?? Colors.black);
  }

  /// Builds the logo widget.
  /// ask for parameters:
  /// [svgAsset] the path of the svg asset
  /// [svgColor] the color of the svg asset
  /// [textColor] the color of the text
Widget _buildLogo(String svgAsset, Color? svgColor, Color textColor) {
  const double textScaleFactor = 0.5; 
  return Row(
    mainAxisAlignment: alignment,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Developed By',
        style: TextStyle(
          color: textColor,
          fontSize: size! - textScaleFactor,
        ),
      ),
      const SizedBox(width: 4),
      SvgPicture.asset(
        svgAsset,
        height: size,
        width: size,
        color: svgColor,
      ),
    ],
  );
}
}
