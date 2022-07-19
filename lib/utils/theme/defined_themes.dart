import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefinedThemes {
  static ThemeData blueWhaleDark = FlexThemeData.dark(
    scheme: FlexScheme.hippieBlue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    appBarElevation: 12.0,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      toggleButtonsRadius: 12.0,
      bottomNavigationBarElevation: 2.5,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.notoSans().fontFamily,
    darkIsTrueBlack: true,
  );

  static ThemeData blueWhaleLight = FlexThemeData.light(
    scheme: FlexScheme.hippieBlue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 20,
    appBarOpacity: 0.90,
    appBarElevation: 12.0,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendOnColors: false,
      toggleButtonsRadius: 12.0,
      appBarBackgroundSchemeColor: SchemeColor.primary,
      bottomNavigationBarElevation: 2.5,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static ThemeData moneyLight = FlexColorScheme.light(scheme: FlexScheme.money).toTheme;
  static ThemeData moneyDark = FlexColorScheme.dark(scheme: FlexScheme.money).toTheme;
}
