import 'package:ecoparking_flutter/widgets/selection_card/selection_card_styles.dart';
import 'package:flutter/material.dart';

class SelectCircle extends StatelessWidget {
  final bool isSelected;
  final double? size;

  const SelectCircle({
    super.key,
    required this.isSelected,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? buildSelectedCircle(context, size: size)
        : buildUnselectedCircle(context, size: size);
  }
}

Widget buildSelectedCircle(BuildContext context, {double? size}) {
  return Container(
    width: size ?? SelectionCardStyles.selectionCircleSize,
    height: size ?? SelectionCardStyles.selectionCircleSize,
    padding:
        EdgeInsets.all((size ?? SelectionCardStyles.selectionCircleSize) * 0.1),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: SelectionCardStyles.borderWidth,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}

Widget buildUnselectedCircle(BuildContext context, {double? size}) {
  return Container(
    width: size ?? SelectionCardStyles.selectionCircleSize,
    height: size ?? SelectionCardStyles.selectionCircleSize,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: SelectionCardStyles.borderWidth,
      ),
    ),
  );
}
