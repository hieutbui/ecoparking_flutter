import 'package:ecoparking_flutter/pages/parking_details/parking_details.dart';
import 'package:flutter/material.dart';

class ParkingDetailsView extends StatelessWidget {
  final ParkingDetailsController controller;

  const ParkingDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Parking Details: ${controller.widget.parking.id}'),
    );
  }
}
