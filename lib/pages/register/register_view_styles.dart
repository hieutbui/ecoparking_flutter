import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterViewStyles {
  static const double loginAreaSpacing = 8.0;
  static const double textInputSpacing = 26.0;
  static const double inputBottomSpacing = 40.0;
  static const double signUpButtonBottomSpacing = 60.0;
  static const double dividerThickness = 1.0;
  static const double dividerBottomSpacing = 40.0;
  static const double socialButtonSpacing = 16.0;

  static const EdgeInsetsGeometry padding = EdgeInsets.only(
    left: 28.0,
    right: 28.0,
    top: 32.0,
  );
  static const EdgeInsetsGeometry loginAreaPadding = EdgeInsets.only(
    bottom: 20.0,
  );
  static const EdgeInsetsGeometry dividerTextPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
  );

  static TextStyle questionTextStyle = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF9C9494),
  );
  static TextStyle loginTextStyle(BuildContext context) =>
      GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      );
}
