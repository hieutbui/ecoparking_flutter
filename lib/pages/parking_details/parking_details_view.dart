import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/parking_details/parking_details.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class ParkingDetailsView extends StatelessWidget {
  final ParkingDetailsController controller;

  const ParkingDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parking Details',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => NavigationUtils.navigateTo(
            context: context,
            path: AppPaths.home.path,
          ),
        ),
      ),
      body: Center(
        child: Text('Parking Details: ${controller.widget.parking.id}'),
      ),
    );
  }
}
