import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method.dart';
import 'package:ecoparking_flutter/pages/pick_spot/pick_spot_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class PickSpot extends StatefulWidget {
  const PickSpot({super.key});

  @override
  PickSpotController createState() => PickSpotController();
}

class PickSpotController extends State<PickSpot> with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedSelectSpot() {
    loggy.info('Select Vehicle tapped');

    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog.fullscreen(
        child: ChoosePaymentMethod(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => PickSpotView(controller: this);
}
