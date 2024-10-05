import 'package:flutter/material.dart';

class HourSelectionButton extends StatelessWidget {
  final TimeOfDay hour;
  final void Function(TimeOfDay) onPressed;
  final bool? isSelected;
  final bool? isDisabled;

  const HourSelectionButton({
    super.key,
    required this.hour,
    required this.onPressed,
    this.isSelected,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: isSelected ?? false,
      label: Text(hour.format(context)),
      labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isSelected == true
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
      selectedColor: Theme.of(context).colorScheme.primary,
      checkmarkColor: Colors.white,
      disabledColor: Theme.of(context).colorScheme.tertiary,
      onSelected: isDisabled == true
          ? null
          : (selected) {
              if (selected) {
                onPressed(hour);
              }
            },
      side: BorderSide(
        color: isDisabled == true
            ? Colors.transparent
            : isSelected == true
                ? Colors.transparent
                : Theme.of(context).colorScheme.primary,
        width: 1,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
