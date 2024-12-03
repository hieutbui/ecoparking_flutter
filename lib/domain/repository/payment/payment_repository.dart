import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentRepository {
  Future<Map<String, dynamic>?> createPaymentIntent(
      CreatePaymentIntentRequestBody body);

  Future<PaymentIntent> confirmPaymentIntentWeb();
}
