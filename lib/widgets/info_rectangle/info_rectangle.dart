import 'package:ecoparking_flutter/widgets/info_rectangle/info_rectangle_styles.dart';
import 'package:flutter/material.dart';

class InfoRectangle extends StatelessWidget {
  final InfoRectangleType type;
  final String label;
  final EdgeInsetsGeometry? padding;
  final Color? labelColor;
  final double? spacing;
  final double? width;
  final double? height;
  final double? iconSize;
  final IconData? icon;

  const InfoRectangle({
    super.key,
    required this.type,
    required this.label,
    this.padding,
    this.labelColor,
    this.spacing,
    this.width,
    this.height,
    this.iconSize,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: InfoRectangleStyle.getDecoration(context, type),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color:
                  labelColor ?? InfoRectangleStyle.getLabelColor(context, type),
              size: iconSize ?? InfoRectangleStyle.defaultIconSize,
            ),
            SizedBox(width: spacing ?? InfoRectangleStyle.defaultSpacing),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: labelColor ??
                      InfoRectangleStyle.getLabelColor(context, type),
                ),
          ),
        ],
      ),
    );
  }
}

enum InfoRectangleType {
  hollow,
  filled,
}
