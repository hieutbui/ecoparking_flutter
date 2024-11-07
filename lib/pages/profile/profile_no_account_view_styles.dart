import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileNoAccountViewStyles {
  static const double socialButtonsSpacing = 16.0;
  static const double dividerSpacing = 100.0;
  static const double dividerThickness = 1.0;
  static const double signUpAreaSpacing = 8.0;

  static const EdgeInsetsGeometry padding = EdgeInsets.only(
    left: 50.0,
    right: 50.0,
    top: 32.0,
  );
  static const EdgeInsetsGeometry dividerTextPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
  );
  static const EdgeInsetsGeometry signUpAreaPadding = EdgeInsets.only(
    bottom: 20.0,
  );

  static TextStyle dividerTextStyle(BuildContext context) =>
      GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      );
  static TextStyle questionTextStyle = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF9C9494),
  );
  static TextStyle signUpTextStyle(BuildContext context) =>
      GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      );
}
