import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details_view_styles.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/info_rectangle/info_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class ParkingDetailsView extends StatelessWidget {
  final ParkingDetailsController controller;

  const ParkingDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Parking Details',
      body: Padding(
        padding: ParkingDetailsViewStyles.padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GFImageOverlay(
                      height: ParkingDetailsViewStyles.imageHeight,
                      borderRadius: ParkingDetailsViewStyles.imageBorderRadius,
                      shape: BoxShape.rectangle,
                      image: controller.parking != null
                          ? NetworkImage(
                              controller.parking!.image,
                              scale: 1,
                            )
                          : null,
                    ),
                    const SizedBox(
                      height: ParkingDetailsViewStyles.normalSpacing,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.tertiary,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: ParkingDetailsViewStyles.normalSpacing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                controller.parking?.parkingName ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                controller.parking?.address ?? '',
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
                        IconButton(
                          onPressed: controller.onPressedBookMark,
                          icon: const Icon(Icons.bookmark_border),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: ParkingDetailsViewStyles.wideSpacing,
                    ),
                    //TODO: Add details about distance
                    InfoRectangle(
                      type: InfoRectangleType.hollow,
                      label:
                          '${controller.parking?.availableSlot} / ${controller.parking?.totalSlot} Available',
                      icon: Icons.directions_car,
                      padding: ParkingDetailsViewStyles.infoRectanglePadding,
                    ),
                    const SizedBox(
                      height: ParkingDetailsViewStyles.wideSpacing,
                    ),
                    Text(
                      'Parking Fee',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.black),
                    ),
                    ...?controller.buildShiftPrices(),
                    const SizedBox(
                      height: ParkingDetailsViewStyles.wideSpacing,
                    ),
                    Text(
                      'Long term Fee',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.black),
                    ),
                    GFListTile(
                      titleText: 'Daily',
                      subTitleText: controller.parking?.pricePerDay.toString(),
                      icon: const Icon(Icons.money_outlined),
                      onTap: () => controller.onPressedLongTermPrice(
                        ParkingFeeTypes.daily,
                      ),
                    ),
                    GFListTile(
                      titleText: 'Monthly',
                      subTitleText:
                          controller.parking?.pricePerMonth.toString(),
                      icon: const Icon(Icons.money_outlined),
                      onTap: () => controller.onPressedLongTermPrice(
                        ParkingFeeTypes.monthly,
                      ),
                    ),
                    GFListTile(
                      titleText: 'Annually',
                      subTitleText: controller.parking?.pricePerYear.toString(),
                      icon: const Icon(Icons.money_outlined),
                      onTap: () => controller.onPressedLongTermPrice(
                        ParkingFeeTypes.annually,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: ParkingDetailsViewStyles.bottomContainerPadding,
              decoration: ParkingDetailsViewStyles.bottomContainerDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ActionButton(
                    type: ActionButtonType.negative,
                    label: 'Cancel',
                    isShowArrow: false,
                    onPressed: controller.onPressedCancel,
                    width: ParkingDetailsViewStyles.actionButtonWidth,
                  ),
                  ActionButton(
                    type: ActionButtonType.positive,
                    label: 'Book Now',
                    isShowArrow: false,
                    onPressed: controller.onPressedBookNow,
                    width: ParkingDetailsViewStyles.actionButtonWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
