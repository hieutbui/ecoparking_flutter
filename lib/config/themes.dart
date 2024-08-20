import 'package:ecoparking_flutter/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoParkingThemes {
  static var fallbackTextTheme = TextTheme(
    displayLarge: GoogleFonts.jost(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    displayMedium: GoogleFonts.jost(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    displaySmall: GoogleFonts.jost(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    headlineLarge: GoogleFonts.jost(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    headlineMedium: GoogleFonts.jost(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0,
    ),
    headlineSmall: GoogleFonts.jost(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0,
    ),
    titleLarge: GoogleFonts.jost(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    titleMedium: GoogleFonts.jost(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.0,
    ),
    titleSmall: GoogleFonts.jost(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.0,
    ),
    bodyLarge: GoogleFonts.jost(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0,
    ),
    bodyMedium: GoogleFonts.jost(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0,
    ),
    bodySmall: GoogleFonts.jost(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0,
    ),
    labelLarge: GoogleFonts.jostTextTheme().labelLarge,
    labelMedium: GoogleFonts.jostTextTheme().labelMedium,
    labelSmall: GoogleFonts.jostTextTheme().labelSmall,
  );

  static ThemeData buildTheme(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConfig.primaryColor,
          primary: AppConfig.primaryColor,
          onPrimary: AppConfig.onPrimaryColor,
          primaryContainer: AppConfig.primaryContainerColor,
          onPrimaryContainer: AppConfig.primaryColor,
          secondary: AppConfig.secondaryColor,
          onSecondary: AppConfig.onSecondaryColor,
          secondaryContainer: AppConfig.secondaryContainerColor,
          onSecondaryContainer: AppConfig.onSecondaryContainerColor,
          tertiary: AppConfig.tertiaryColor,
          onTertiary: AppConfig.onTertiaryColor,
          tertiaryContainer: AppConfig.tertiaryContainerColor,
          onTertiaryContainer: AppConfig.onTertiaryContainerColor,
          error: AppConfig.errorColor,
          onError: AppConfig.onErrorColor,
          errorContainer: AppConfig.errorContainerColor,
          onErrorContainer: AppConfig.onErrorContainerColor,
          surface: AppConfig.surfaceColor,
          onSurface: AppConfig.onSurfaceColor,
          surfaceContainerHighest: AppConfig.surfaceVariantColor,
          onSurfaceVariant: AppConfig.onSurfaceVariantColor,
          surfaceContainer: AppConfig.surfaceContainerColor,
          onInverseSurface: AppConfig.onInverseSurface,
          outline: AppConfig.outlineColor,
          outlineVariant: AppConfig.outlineVariantColor,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppConfig.primaryColor,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.jost().fontFamily,
        textTheme: fallbackTextTheme,
      );
}
