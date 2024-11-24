import 'package:flutter/material.dart';

class AppConfig {
  static const Color primaryColor = Color(0xFFBC0063);
  static const Color onPrimaryColor = Colors.white;
  static Color primaryContainerColor = const Color(0xFFBC0063).withOpacity(0.1);
  static const Color secondaryColor = Color(0xFF565656);
  static const Color onSecondaryColor = Colors.white;
  static const Color secondaryContainerColor = Colors.white;
  static const Color onSecondaryContainerColor = primaryColor;
  static const Color tertiaryColor = Color(0xFFD9D9D9);
  static const Color onTertiaryColor = primaryColor;
  static Color tertiaryContainerColor =
      const Color(0xFFD9D9D9).withOpacity(0.5);
  static const Color onTertiaryContainerColor = Color(0xFFB7B0B0);
  static const Color errorColor = Color(0xFFDF321D);
  static const Color onErrorColor = Colors.white;
  static const Color errorContainerColor = Color(0xFFDF321D);
  static const Color onErrorContainerColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  static const Color onSurfaceColor = Color(0xFF353535);
  static const Color surfaceVariantColor = Color(0xFFE5E5E5);
  static const Color onSurfaceVariantColor = Colors.black;
  static const Color surfaceContainerColor = Color(0xFFF4F4F4);
  static const Color onSurfaceContainerColor = Colors.black;
  static const Color onInverseSurface = Color(0xFFF4EFF4);
  static const Color outlineColor = Colors.black;
  static const Color outlineVariantColor = Color(0xFFCAC4D0);

  static const double appColumnWidth = 360;

  static const String appTitle = 'EcoParking';
  static const String localRedirectURL = 'http://localhost:3000';
  static const String repositoryURL =
      'https://hieutbui.github.io/ecoparking_flutter';
  static const String releaseDomain = '$repositoryURL/release';
  static const String userAgentPackageName = 'com.example.ecoparking_flutter';
}
