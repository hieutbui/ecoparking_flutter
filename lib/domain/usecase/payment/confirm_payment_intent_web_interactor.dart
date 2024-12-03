import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/payment/payment_repository.dart';
import 'package:ecoparking_flutter/domain/state/payment/confirm_payment_intent_web_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class ConfirmPaymentIntentWebInteractor with InteractorLoggy {
  final PaymentRepository _paymentRepository = getIt.get<PaymentRepository>();

  Stream<Either<Failure, Success>> execute() async* {
    try {
      yield const Right(ConfirmPaymentIntentWebLoading());

      final PaymentIntent? paymentIntent =
          await _paymentRepository.confirmPaymentIntentWeb();

      if (paymentIntent != null) {
        yield Right(
            ConfirmPaymentIntentWebSuccess(paymentIntent: paymentIntent));
      } else {
        yield const Left(ConfirmPaymentIntentWebEmpty());
      }
    } on StripeException catch (e) {
      loggy.error(
          'ConfirmPaymentIntentWebInteractor::execute(): stripe failure: $e');
      yield Left(ConfirmPaymentIntentWebStripeException(exception: e));
    } on StripeError catch (e) {
      loggy.error(
          'ConfirmPaymentIntentWebInteractor::execute(): stripe error: $e');
      yield Left(ConfirmPaymentIntentWebStripeError(stripeError: e));
    } catch (e) {
      loggy.error(
          'ConfirmPaymentIntentWebInteractor::execute(): confirm payment intent failure: $e');
      yield Left(ConfirmPaymentIntentWebFailure(exception: e));
    }
  }
}
