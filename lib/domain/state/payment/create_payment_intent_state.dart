import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class CreatePaymentIntentState with EquatableMixin {
  const CreatePaymentIntentState();

  @override
  List<Object?> get props => [];
}

class CreatePaymentIntentInitial extends Initial
    implements CreatePaymentIntentState {
  const CreatePaymentIntentInitial() : super();

  @override
  List<Object?> get props => [];
}

class CreatePaymentIntentLoading extends Initial
    implements CreatePaymentIntentState {
  const CreatePaymentIntentLoading() : super();

  @override
  List<Object?> get props => [];
}

class CreatePaymentIntentSuccess extends Success
    implements CreatePaymentIntentState {
  final CreatePaymentIntentResponse paymentIntent;

  const CreatePaymentIntentSuccess({required this.paymentIntent});

  @override
  List<Object?> get props => [paymentIntent];
}

class CreatePaymentIntentStripeError extends Failure
    implements CreatePaymentIntentState {
  final StripeError stripeError;

  const CreatePaymentIntentStripeError({required this.stripeError});

  @override
  List<Object?> get props => [stripeError];
}

class CreatePaymentIntentStripeException extends Failure
    implements CreatePaymentIntentState {
  final StripeException exception;

  const CreatePaymentIntentStripeException({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class CreatePaymentIntentEmpty extends Failure
    implements CreatePaymentIntentState {
  const CreatePaymentIntentEmpty();

  @override
  List<Object?> get props => [];
}

class CreatePaymentIntentFailure extends Failure
    implements CreatePaymentIntentState {
  final dynamic exception;

  const CreatePaymentIntentFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
