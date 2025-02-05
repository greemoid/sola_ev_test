import 'package:flutter/material.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';

class FontStyles {
  static const double _extraLargeFontSize = 32;
  static const double _mediumLargeFontSize = 24;
  static const double _bodyLargeFontSize = 20;
  static const double _bodyMediumFontSize = 15;
  static const double _bodySmallFontSize = 13;

  static const TextStyle titleLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: _extraLargeFontSize,
  );

  static const TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: _mediumLargeFontSize,
    color: ColorPalette.mainTextColor,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: _bodyLargeFontSize,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: _bodyMediumFontSize,
  );

  static const TextStyle bodySmall = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: _bodySmallFontSize,
  );
}
