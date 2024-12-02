import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_response.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentRepository {
  Future<CreatePaymentIntentResponse> createPaymentIntent(
      CreatePaymentIntentRequestBody body);

  Future<PaymentIntent> confirmPaymentIntentWeb();
}
