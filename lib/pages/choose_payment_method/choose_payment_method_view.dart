import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ChoosePaymentMethodView extends StatelessWidget {
  final ChoosePaymentMethodController controller;

  const ChoosePaymentMethodView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Payment',
      body: Center(
        child: ActionButton(
          type: ActionButtonType.positive,
          label: 'Open Select Vehicle',
          onPressed: controller.onPressedSelectPaymentMethod,
        ),
      ),
    );
  }
}
