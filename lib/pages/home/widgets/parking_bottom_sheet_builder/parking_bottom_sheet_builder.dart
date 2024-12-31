import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/pages/home/model/parking_bottom_sheet_action.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class ParkingBottomSheetBuilder {
  static Widget build(
    BuildContext context,
    Parking parking, {
    required ValueNotifier<bool> isSelectFavoriteNotifier,
    required double cheapestPrice,
    void Function(Parking)? onBookmark,
    void Function(Parking)? onNavigate,
  }) {
    final String? image = parking.image;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Chi tiết',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () => onNavigate?.call(parking),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Chỉ đường',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(width: 4.0),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GFImageOverlay(
                height: 150,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle,
                image: image != null ? NetworkImage(image, scale: 1) : null,
              ),
              const SizedBox(height: 12),
              Divider(
                color: Theme.of(context).colorScheme.tertiary,
                height: 1.0,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          parking.parkingName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          parking.address,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: const Color(0xFFA1A1A1)),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: isSelectFavoriteNotifier,
                    builder: (context, isSelectFavorite, child) {
                      return IconButton(
                        icon: Icon(
                          isSelectFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () => onBookmark?.call(parking),
                      );
                    },
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Chỉ từ: ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color(0xFFA1A1A1),
                          ),
                    ),
                    TextSpan(
                      text: cheapestPrice.toString(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    TextSpan(
                      text: ' / giờ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA1A1A1),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ActionButton(
                      type: ActionButtonType.negative,
                      label: 'Chi tiết',
                      isShowArrow: true,
                      onPressed: () => {
                        Navigator.of(context).pop(
                          ParkingBottomSheetAction.details,
                        ),
                      },
                    ),
                  ),
                  Expanded(
                    child: ActionButton(
                      type: ActionButtonType.positive,
                      label: 'Đặt ngay',
                      isShowArrow: false,
                      onPressed: () => Navigator.of(context).pop(
                        ParkingBottomSheetAction.bookNow,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
