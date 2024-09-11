import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) => ParkingDetailsView(controller: this);
}
