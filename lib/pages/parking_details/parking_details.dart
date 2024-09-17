import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class ParkingDetails extends StatefulWidget {
  final Parking parking;

  const ParkingDetails({
    super.key,
    required this.parking,
  });

  @override
  ParkingDetailsController createState() => ParkingDetailsController();
}

class ParkingDetailsController extends State<ParkingDetails>
    with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String pricePerHourTitle(ShiftType shiftType) {
    switch (shiftType) {
      case ShiftType.morning:
        return 'Morning';
      case ShiftType.afternoon:
        return 'Afternoon';
      case ShiftType.night:
        return 'Night';
      case ShiftType.other:
        return 'Other (Contact for more info)';
    }
  }

  List<Widget> buildShiftPrices() {
    return widget.parking.pricePerHour
        .map(
          (shiftPrice) => GFListTile(
            titleText:
                '${shiftPrice.startTime.format(context)} - ${shiftPrice.endTime.format(context)}',
            subTitleText: shiftPrice.price.toString(),
            icon: const Icon(Icons.monetization_on),
            onTap: () {},
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) => ParkingDetailsView(controller: this);
}
