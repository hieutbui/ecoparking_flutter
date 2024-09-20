import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class BookParkingDetailsView extends StatelessWidget {
  final BookParkingDetailsController controller;

  const BookParkingDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Book Parking Details',
      body: Center(
        child: ActionButton(
          type: ActionButtonType.positive,
          label: 'Open Select Vehicle',
          onPressed: controller.onPressedSelectVehicle,
        ),
      ),
    );
  }
}
