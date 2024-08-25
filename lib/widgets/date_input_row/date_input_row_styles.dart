import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateInputRowStyles {
  static const double suffixIconSize = 16.0;

  static const InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide.none,
  );

  static TextStyle hintTextStyle(BuildContext context) => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        letterSpacing: 0.0,
      );
  static TextStyle inputtedTextStyle = GoogleFonts.poppins(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: 0.0,
  );
}
