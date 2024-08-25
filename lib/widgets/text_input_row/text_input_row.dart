import 'package:ecoparking_flutter/widgets/text_input_row/text_input_row_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputRow extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool isShowObscure;
  final double width;
  final double height;

  const TextInputRow({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isShowObscure = false,
    this.width = double.infinity,
    this.height = TextInputRowStyles.height,
  });

  @override
  State<TextInputRow> createState() => _TextInputRowState();
}

class _TextInputRowState extends State<TextInputRow> {
  late FocusNode _focusNode;
  late bool _isObscure;

  bool _isFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isObscure = widget.isShowObscure;

    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        style: TextInputRowStyles.inputtedTextStyle,
        obscureText: _isObscure,
        decoration: InputDecoration(
          border: TextInputRowStyles.inputBorder,
          focusedBorder: TextInputRowStyles.focusedBorder(context),
          hintText: widget.hintText,
          hintStyle: TextInputRowStyles.hintTextStyle(context),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: _isFocus
                ? Theme.of(context).colorScheme.primary
                : widget.controller.text.isNotEmpty
                    ? Colors.black
                    : Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          suffixIcon: widget.isShowObscure
              ? IconButton(
                  onPressed: _toggleObscure,
                  icon: Icon(
                    _isObscure
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: _isFocus
                        ? Theme.of(context).colorScheme.primary
                        : widget.controller.text.isNotEmpty
                            ? Colors.black
                            : Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                )
              : Icon(
                  widget.suffixIcon,
                  color: _isFocus
                      ? Theme.of(context).colorScheme.primary
                      : widget.controller.text.isNotEmpty
                          ? Colors.black
                          : Theme.of(context).colorScheme.onTertiaryContainer,
                ),
          fillColor: Theme.of(context).colorScheme.tertiaryContainer,
          filled: true,
        ),
      ),
    );
  }
}
