import 'package:ecoparking_flutter/pages/pick_spot/pick_spot.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class SelectVehicle extends StatefulWidget {
  const SelectVehicle({super.key});

  @override
  SelectVehicleController createState() => SelectVehicleController();
}

class SelectVehicleController extends State<SelectVehicle>
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
        child: PickSpot(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SelectVehicleView(controller: this);
}
