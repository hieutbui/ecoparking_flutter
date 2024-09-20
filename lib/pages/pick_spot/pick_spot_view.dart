import 'package:ecoparking_flutter/pages/pick_spot/pick_spot.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class PickSpotView extends StatelessWidget {
  final PickSpotController controller;

  const PickSpotView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Pick Parking Spot',
      body: Center(
        child: ActionButton(
          type: ActionButtonType.positive,
          label: 'Open Select Vehicle',
          onPressed: controller.onPressedSelectSpot,
        ),
      ),
    );
  }
}
