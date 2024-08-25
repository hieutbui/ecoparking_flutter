import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecoparking_flutter/domain/models/account.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownGenderStyles {
  static const double buttonHeight = 56.0;

  static ButtonStyleData buttonStyleData(
    BuildContext context,
    bool isFocus,
  ) =>
      ButtonStyleData(
        padding: buttonPadding,
        height: buttonHeight,
        width: double.infinity,
        decoration: buttonDecoration(context, isFocus),
      );
  static IconStyleData iconStyleData(
    BuildContext context,
    bool isFocus,
    Genders? selectedGender,
  ) =>
      IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: isFocus
              ? Theme.of(context).colorScheme.primary
              : selectedGender != null
                  ? Colors.black
                  : Theme.of(context).colorScheme.onTertiaryContainer,
        ),
      );
  static DropdownStyleData dropdownStyleData(
    BuildContext context,
    bool isFocus,
  ) =>
      DropdownStyleData(
        elevation: 1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: isFocus
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 1.0,
          ),
        ),
      );

  static BoxDecoration buttonDecoration(
    BuildContext context,
    bool isFocus,
  ) =>
      BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: isFocus
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: 1.0,
        ),
      );

  static const EdgeInsetsGeometry buttonPadding = EdgeInsets.only(
    left: 10.0,
    right: 8.0,
  );

  static TextStyle hintStyle(BuildContext context) => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        letterSpacing: 0.0,
      );
  static TextStyle itemsTextStyle = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: 0.0,
  );
}
