import 'package:ecoparking_flutter/pages/review_summary/widgets/loading_button.dart';
import 'package:ecoparking_flutter/utils/conditional_import/stripe/stripe_payment_element/stripe_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutWeb extends StatelessWidget {
  final String clientSecret;
  final void Function(CardFieldInputDetails?) onCardChanged;
  final Future<void> Function() onPressedPayment;

  const CheckoutWeb({
    super.key,
    required this.clientSecret,
    required this.onCardChanged,
    required this.onPressedPayment,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          StripePayment(
            clientSecret: clientSecret,
            onCardChanged: onCardChanged,
          ),
          LoadingButton(
            title: 'Thanh toán',
            onPressed: onPressedPayment,
          ),
        ],
      ),
    );
  }
}
