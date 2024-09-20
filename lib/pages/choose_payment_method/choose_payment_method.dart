import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method_view.dart';
import 'package:ecoparking_flutter/pages/review_summary/review_summary.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod({super.key});

  @override
  ChoosePaymentMethodController createState() =>
      ChoosePaymentMethodController();
}

class ChoosePaymentMethodController extends State<ChoosePaymentMethod>
    with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedSelectPaymentMethod() {
    loggy.info('Select Payment Method tapped');

    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog.fullscreen(
        child: ReviewSummary(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      ChoosePaymentMethodView(controller: this);
}
