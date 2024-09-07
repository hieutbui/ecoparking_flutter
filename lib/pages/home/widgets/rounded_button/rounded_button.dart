import 'package:ecoparking_flutter/pages/home/widgets/rounded_button/rounded_button_styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const RoundedButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: RoundedButtonStyles.backgroundColor,
        borderRadius: RoundedButtonStyles.borderRadius,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: RoundedButtonStyles.getIconColor(context),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
