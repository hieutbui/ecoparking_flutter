import 'package:ecoparking_flutter/data/datasource/payment/payment_datasource.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/payment/payment_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDataSource _paymentDataSource = getIt.get<PaymentDataSource>();

  @override
  Future<Map<String, dynamic>?> createPaymentIntent(
      CreatePaymentIntentRequestBody body) {
    return _paymentDataSource.createPaymentIntent(body);
  }

  @override
  Future<PaymentIntent> confirmPaymentIntentWeb() {
    return _paymentDataSource.confirmPaymentIntentWeb();
  }
}
