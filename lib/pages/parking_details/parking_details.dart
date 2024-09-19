import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
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
  Parking get parking => widget.parking;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> buildShiftPrices() {
    return parking.pricePerHour
        .map(
          (shiftPrice) => GFListTile(
            titleText:
                '${shiftPrice.startTime.format(context)} - ${shiftPrice.endTime.format(context)}',
            subTitleText: shiftPrice.price.toString(),
            icon: const Icon(Icons.monetization_on),
            onTap: () => onPressedShiftPrice(shiftPrice),
          ),
        )
        .toList();
  }

  void onPressedBookMark() {
    loggy.info('Book mark tapped');
  }

  void onPressedShiftPrice(ShiftPrice shift) {
    loggy.info('Shift price tapped: $shift');

    _showBookParkingDetails(ParkingFeeTypes.hourly);
  }

  void onPressedLongTermPrice(ParkingFeeTypes type) {
    loggy.info('Long term price tapped: $type');

    _showBookParkingDetails(type);
  }

  void _showBookParkingDetails(ParkingFeeTypes type) {
    loggy.info('navigate to book parking details: $type');

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: BookParkingDetails(),
      ),
    );
  }

  void onPressedBookNow() {
    loggy.info('Book now tapped');
  }

  @override
  Widget build(BuildContext context) => ParkingDetailsView(controller: this);
}
