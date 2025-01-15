part 'package:{{{full_path}}}/variables/constants/width_constants.dart';

class WidthValues {
  // ---------------------------------------------------
  // <---------------- Radius values ------------------>
  // ---------------------------------------------------

  /// No radius (0)
  static const radiusNone = 0.0;

  /// Extra extra small radius (0.5)
  static final radiusXxs = _WidthConstants.spacing.getSpacing(0.5);

  /// Extra small radius (1)
  static final radiusXs = _WidthConstants.spacing.getSpacing(1);

  /// Small radius (1.5)
  static final radiusSm = _WidthConstants.spacing.getSpacing(1.5);

  /// Medium radius (2)
  static final radiusMd = _WidthConstants.spacing.getSpacing(2);

  /// Large radius (2.5)
  static final radiusLg = _WidthConstants.spacing.getSpacing(2.5);

  /// Extra large radius (3)
  static final radiusXl = _WidthConstants.spacing.getSpacing(3);

  /// Extra extra large radius (4)
  static final radius2xl = _WidthConstants.spacing.getSpacing(4);

  /// 3Extra large radius (5)
  static final radius3xl = _WidthConstants.spacing.getSpacing(5);

  /// 4Extra large radius (6)
  static final radius4xl = _WidthConstants.spacing.getSpacing(6);

  /// Fully rounded (circular) radius. Equivalent to 9999px
  static const radiusFull = 9999.0;

  // ----------------------------------------------------
  // <---------------- Spacing values ------------------>
  // ----------------------------------------------------

  /// No spacing (0)
  static final spacingNone = _WidthConstants.spacing.getSpacing(0);

  /// Extra extra small spacing (0.5)
  static final spacingXxs = _WidthConstants.spacing.getSpacing(0.5);

  /// Extra small spacing (1)
  static final spacingXs = _WidthConstants.spacing.getSpacing(1);

  /// Small spacing (1.5)
  static final spacingSm = _WidthConstants.spacing.getSpacing(1.5);

  /// Medium spacing (2)
  static final spacingMd = _WidthConstants.spacing.getSpacing(2);

  /// Double medium spacing (2.5)
  static final spacing2Md = _WidthConstants.spacing.getSpacing(2.5);

  /// Large spacing (3)
  static final spacingLg = _WidthConstants.spacing.getSpacing(3);

  /// Extra large spacing (4)
  static final spacingXl = _WidthConstants.spacing.getSpacing(4);

  /// Extra extra large spacing (5)
  static final spacing2xl = _WidthConstants.spacing.getSpacing(5);

  /// 3Extra large spacing (6)
  static final spacing3xl = _WidthConstants.spacing.getSpacing(6);

  /// 4Extra large spacing (8)
  static final spacing4xl = _WidthConstants.spacing.getSpacing(8);

  /// 5Extra large spacing (10)
  static final spacing5xl = _WidthConstants.spacing.getSpacing(10);

  /// 6Extra large spacing (12)
  static final spacing6xl = _WidthConstants.spacing.getSpacing(12);

  /// 7Extra large spacing (16)
  static final spacing7xl = _WidthConstants.spacing.getSpacing(16);

  /// 8Extra large spacing (20)
  static final spacing8xl = _WidthConstants.spacing.getSpacing(20);

  /// 9Extra large spacing (24)
  static final spacing9xl = _WidthConstants.spacing.getSpacing(24);

  /// 10Extra large spacing (32)
  static final spacing10xl = _WidthConstants.spacing.getSpacing(32);

  /// 11Extra large spacing (40)
  static final spacing11xl = _WidthConstants.spacing.getSpacing(40);

  // ----------------------------------------------------
  // <----------- Container spacing values ------------->
  // ----------------------------------------------------

  /// Container padding (4), equivalent to [spacingXl]
  static final containerPadding = _WidthConstants.spacing.getSpacing(4);

  // -------------------------------------------------
  // <----------- Common spacing values ------------->
  // -------------------------------------------------

  /// Common padding (2), equivalent to [spacingMd]
  static final padding = spacingMd;

  /// Common margin (4), equivalent to [spacingXl]
  static final margin = spacingXl;
}
