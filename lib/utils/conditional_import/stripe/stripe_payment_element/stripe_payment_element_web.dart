import 'package:flutter/widgets.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';

class StripePaymentElement extends StatelessWidget {
  final String clientSecret;
  final void Function(CardFieldInputDetails?) onCardChanged;

  const StripePaymentElement({
    super.key,
    required this.clientSecret,
    required this.onCardChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PaymentElement(
      clientSecret: clientSecret,
      onCardChanged: onCardChanged,
    );
  }
}
