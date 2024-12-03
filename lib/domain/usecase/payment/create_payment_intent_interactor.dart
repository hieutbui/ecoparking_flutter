import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_response.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/payment/payment_repository.dart';
import 'package:ecoparking_flutter/domain/state/payment/create_payment_intent_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CreatePaymentIntentInteractor with InteractorLoggy {
  final PaymentRepository _paymentRepository = getIt.get<PaymentRepository>();

  Stream<Either<Failure, Success>> execute(
      CreatePaymentIntentRequestBody body) async* {
    try {
      yield const Right(CreatePaymentIntentLoading());

      final Map<String, dynamic>? paymentIntent =
          await _paymentRepository.createPaymentIntent(body);

      if (paymentIntent != null) {
        yield Right(CreatePaymentIntentSuccess(
            paymentIntent:
                CreatePaymentIntentResponse.fromJson(paymentIntent)));
      } else {
        yield const Left(CreatePaymentIntentEmpty());
      }
    } on StripeException catch (e) {
      loggy.error(
          'CreatePaymentIntentInteractor::execute(): stripe failure: $e');
      yield Left(CreatePaymentIntentStripeException(exception: e));
    } on StripeError catch (e) {
      loggy.error('CreatePaymentIntentInteractor::execute(): stripe error: $e');
      yield Left(CreatePaymentIntentStripeError(stripeError: e));
    } catch (e) {
      loggy.error(
          'CreatePaymentIntentInteractor::execute(): create payment intent failure: $e');
      yield Left(CreatePaymentIntentFailure(exception: e));
    }
  }
}
