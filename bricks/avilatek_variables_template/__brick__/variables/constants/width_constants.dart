/// This Consts file was generated using Mason. You can customize it to fit your needs.
/// Feel free to add any constants that you think will be useful for your project.
class WidthConstants {
  /// Grid system's base value. The project uses an {{{grid_system}}} point grid system.
  ///
  /// This means that the minimum size must be {{{grid_system}}} and any other sizes must
  /// be multiples of this value.
  static const _gridSystem = {{grid_system}};

  static final spacing = _Spacing({
    0: _gridSystem * 0,
    0.5: _gridSystem * 0.5,
    1: _gridSystem * 1,
    1.5: _gridSystem * 1.5,
    2: _gridSystem * 2,
    2.5: _gridSystem * 2.5,
    3: _gridSystem * 3,
    4: _gridSystem * 4,
    5: _gridSystem * 5,
    6: _gridSystem * 6,
    8: _gridSystem * 8,
    10: _gridSystem * 10,
    12: _gridSystem * 12,
    16: _gridSystem * 16,
    20: _gridSystem * 20,
    24: _gridSystem * 24,
    32: _gridSystem * 32,
    40: _gridSystem * 40,
    48: _gridSystem * 48,
    56: _gridSystem * 56,
    64: _gridSystem * 64,
    80: _gridSystem * 80,
    96: _gridSystem * 96,
    120: _gridSystem * 120,
    140: _gridSystem * 140,
    160: _gridSystem * 160,
    180: _gridSystem * 180,
    192: _gridSystem * 192,
    256: _gridSystem * 256,
    320: _gridSystem * 320,
    360: _gridSystem * 360,
    400: _gridSystem * 400,
    480: _gridSystem * 480,
  });
}

class _Spacing {
  const _Spacing(this._spacingValues);
  final Map<double, double> _spacingValues;

  double getSpacing(double key) {
    return _spacingValues[key] ?? 0.0;
  }
}
