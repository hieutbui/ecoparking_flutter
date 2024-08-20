import 'package:ecoparking_flutter/widgets/action_button/action_button_styles.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final ActionButtonType type;
  final String label;
  final VoidCallback? onPressed;
  final bool isShowArrow;
  final double arrowSize;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const ActionButton({
    super.key,
    required this.type,
    required this.label,
    this.onPressed,
    this.isShowArrow = false,
    this.arrowSize = AppButtonStyles.defaultArrowSize,
    this.width = AppButtonStyles.defaultButtonWidth,
    this.height = AppButtonStyles.defaultButtonHeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: AppButtonStyles.getButtonDecoration(context, type),
      child: InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppButtonStyles.getLabelColor(context, type),
                    ),
              ),
              if (isShowArrow) ...[
                const SizedBox(width: 14),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppButtonStyles.getLabelColor(context, type),
                  size: arrowSize,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

enum ActionButtonType {
  positive,
  negative,
  hollow,
}
