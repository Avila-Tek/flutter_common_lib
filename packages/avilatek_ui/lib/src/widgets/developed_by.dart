import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [DevelopedByLogo] is a widget that displays the logo of the company
/// The logo can be displayed in different styles: flat, primaryGreen, primaryWhite, and outlined.
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
    return _buildLogo('packages/avilatek_ui/assets/avilatek_ui/developed_by/flat.svg', color);
  }

  /// Returns the primaryGreen style of the logo.
  Widget primaryGreen() {
    return _buildLogo('packages/avilatek_ui/assets/avilatek_ui/developed_by/primary_Green.svg');
  }

  /// Returns the primaryWhite style of the logo.
  Widget primaryWhite() {
    return _buildLogo('packages/avilatek_ui/assets/avilatek_ui/developed_by/primary_White.svg');
  }

  /// Returns the outlined style of the logo.
  Widget outlined() {
    return _buildLogo('packages/avilatek_ui/assets/avilatek_ui/developed_by/outlined.svg');
  }

  /// Builds the logo widget.
  Widget _buildLogo(String svgAsset, [Color? color]) {
    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Developed By',
          style: TextStyle(
            /// Use the logo color if it's not null, otherwise is black
            color: color ?? Colors.black,
            fontSize: size,
          ),
        ),
        const SizedBox(width: 4),

        /// The [svgAsset] argument specifies
        /// the path to the SVG asset used for the logo.
        ///
        /// The [color] argument specifies the color of the logo.
        /// If it is null, the logo will use its default color.
        SvgPicture.asset(
          svgAsset,
          height: size,
          width: size,
          color: color,
        ),
      ],
    );
  }
}
