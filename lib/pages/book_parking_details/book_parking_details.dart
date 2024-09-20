import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details_view.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class BookParkingDetails extends StatefulWidget {
  const BookParkingDetails({
    super.key,
  });

  @override
  BookParkingDetailsController createState() => BookParkingDetailsController();
}

class BookParkingDetailsController extends State<BookParkingDetails>
    with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedSelectVehicle() {
    loggy.info('Select Vehicle tapped');

    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog.fullscreen(
        child: SelectVehicle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BookParkingDetailsView(controller: this);
}
