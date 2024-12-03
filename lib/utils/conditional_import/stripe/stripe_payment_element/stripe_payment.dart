import 'package:ecoparking_flutter/utils/conditional_import/stripe/stripe_payment_element/stripe_payment_element_pseudo.dart'
    if (dart.library.html) 'package:ecoparking_flutter/utils/conditional_import/stripe/stripe_payment_element/stripe_payment_element_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePayment extends StatelessWidget {
  final String clientSecret;
  final void Function(CardFieldInputDetails?) onCardChanged;

  const StripePayment({
    super.key,
    required this.clientSecret,
    required this.onCardChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StripePaymentElement(
      clientSecret: clientSecret,
      onCardChanged: onCardChanged,
    );
  }
}
