import 'package:ecoparking_flutter/widgets/selection_card/select_circle.dart';
import 'package:ecoparking_flutter/widgets/selection_card/selection_card_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isShowSelectCircle;
  final double width;
  final double height;
  final String? subtitle;
  final String? trailingSVG;
  final String? trailingImage;
  final IconData? trailingIcon;
  final Color? titleColor;
  final Color? subtitleColor;
  final double? trailingWidth;
  final double? trailingHeight;
  final double? selectCircleSize;
  final void Function()? onTap;

  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.trailingSVG,
    this.trailingImage,
    this.trailingIcon,
    this.width = double.infinity,
    this.height = SelectionCardStyles.selectionCardSize,
    this.isSelected = false,
    this.isShowSelectCircle = true,
    this.titleColor,
    this.subtitleColor,
    this.trailingWidth,
    this.trailingHeight,
    this.selectCircleSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSelected ? null : onTap,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        padding: SelectionCardStyles.selectionCardPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.all(Radius.circular(23)),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: SelectionCardStyles.borderWidth,
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTrailing(context),
            const SizedBox(width: SelectionCardStyles.trailingSpace),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: titleColor,
                      ),
                ),
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: subtitleColor,
                        ),
                  ),
                ],
              ],
            ),
            if (isShowSelectCircle) ...[
              const Spacer(),
              SelectCircle(isSelected: isSelected),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    if (trailingSVG != null && trailingSVG!.isNotEmpty && trailingSVG != '') {
      return SvgPicture.asset(
        trailingSVG!,
        width: trailingWidth ?? SelectionCardStyles.trailingWidth,
        height: trailingHeight ?? SelectionCardStyles.trailingHeight,
      );
    } else if (trailingImage != null &&
        trailingImage!.isNotEmpty &&
        trailingImage != '') {
      return Image.asset(
        trailingImage!,
        width: trailingWidth ?? SelectionCardStyles.trailingWidth,
        height: trailingHeight ?? SelectionCardStyles.trailingHeight,
      );
    } else {
      return Icon(trailingIcon);
    }
  }
}
