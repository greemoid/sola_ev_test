import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';

import 'font_styles.dart';

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorPalette.primaryColor,
      primary: ColorPalette.primaryColor,
      surface: ColorPalette.backgroundColor,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.onest(textStyle: FontStyles.titleLarge),
      titleMedium: GoogleFonts.onest(textStyle: FontStyles.titleMedium),
      bodyLarge: GoogleFonts.onest(textStyle: FontStyles.bodyLarge),
      bodyMedium: GoogleFonts.onest(textStyle: FontStyles.bodyMedium),
      bodySmall: GoogleFonts.onest(textStyle: FontStyles.bodySmall),
    ));
