import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class ParkingBottomSheetBuilder {
  static Widget build(BuildContext context, Parking parking) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Text(
                'Details',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.black),
              ),
              GFImageOverlay(
                height: 150,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle,
                image: NetworkImage(parking.image, scale: 1),
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
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.bookmark_border),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ActionButton(
                    type: ActionButtonType.negative,
                    label: 'Details',
                    isShowArrow: true,
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      NavigationUtils.navigateTo(
                        context: context,
                        path: AppPaths.parkingDetails.path,
                        params: parking,
                      )
                    },
                    width: 200,
                  ),
                  ActionButton(
                    type: ActionButtonType.positive,
                    label: 'Book Now',
                    isShowArrow: false,
                    onPressed: () => {
                      Navigator.of(context).pop(),
                    },
                    width: 200,
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
