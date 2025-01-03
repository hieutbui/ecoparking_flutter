import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecoparking_flutter/model/account/account.dart';
import 'package:ecoparking_flutter/widgets/dropdown_gender/dropdown_gender_styles.dart';
import 'package:flutter/material.dart';

class DropdownGender extends StatefulWidget {
  final Genders? initialGender;
  final ValueChanged<Genders>? onSelectGender;

  const DropdownGender({
    super.key,
    this.initialGender,
    this.onSelectGender,
  });

  @override
  State<DropdownGender> createState() => _DropdownGenderState();
}

class _DropdownGenderState extends State<DropdownGender> {
  late FocusNode _focusNode;
  bool _isFocus = false;
  Genders? _selectedGender;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });

    if (widget.initialGender != null) {
      _selectedGender = widget.initialGender;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Genders>(
        focusNode: _focusNode,
        value: _selectedGender,
        isExpanded: true,
        hint: Text(
          'Giới tính',
          style: DropdownGenderStyles.hintStyle(context),
        ),
        items: Genders.values
            .map(
              (Genders gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender.toString(),
                  style: DropdownGenderStyles.itemsTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: _selectGender,
        buttonStyleData: DropdownGenderStyles.buttonStyleData(
          context,
          _isFocus,
        ),
        iconStyleData: DropdownGenderStyles.iconStyleData(
          context,
          _isFocus,
          _selectedGender,
        ),
        dropdownStyleData: DropdownGenderStyles.dropdownStyleData(
          context,
          _isFocus,
        ),
      ),
    );
  }

  void _selectGender(Genders? gender) async {
    if (gender != null) {
      setState(() {
        _selectedGender = gender;
      });
      if (widget.onSelectGender != null) {
        widget.onSelectGender!(gender);
      }
    }
  }
}
