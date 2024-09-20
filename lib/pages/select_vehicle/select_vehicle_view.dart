import 'package:ecoparking_flutter/pages/select_vehicle/select_vehicle.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class SelectVehicleView extends StatelessWidget {
  final SelectVehicleController controller;

  const SelectVehicleView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Select Your Vehicle',
      body: Center(
        child: ActionButton(
          type: ActionButtonType.positive,
          label: 'Open',
          onPressed: controller.onPressedSelectVehicle,
        ),
      ),
    );
  }
}
