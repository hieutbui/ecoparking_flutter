import 'package:ecoparking_flutter/widgets/phone_input_row/phone_input_row_styles.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneInputRow extends StatelessWidget {
  final void Function(PhoneNumber?)? onChanged;

  const PhoneInputRow({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      controller: PhoneController(
        initialValue: const PhoneNumber(isoCode: IsoCode.VN, nsn: ''),
      ),
      style: PhoneInputRowStyles.inputtedTextStyle,
      onChanged: onChanged,
      countrySelectorNavigator: const CountrySelectorNavigator.page(),
      validator: PhoneValidator.compose([
        PhoneValidator.required(context, errorText: 'Phone number is required'),
        PhoneValidator.valid(context),
      ]),
      decoration: InputDecoration(
        hintText: 'Phone number',
        hintStyle: PhoneInputRowStyles.hintStyle(context),
        border: const OutlineInputBorder(
          borderRadius: PhoneInputRowStyles.borderRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PhoneInputRowStyles.borderRadius,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: PhoneInputRowStyles.borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: PhoneInputRowStyles.borderRadius,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: PhoneInputRowStyles.borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: PhoneInputRowStyles.borderRadius,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: PhoneInputRowStyles.borderWidth,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiaryContainer,
      ),
    );
  }
}
