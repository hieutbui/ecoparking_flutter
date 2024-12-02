import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class ConfirmPaymentIntentWebState with EquatableMixin {
  const ConfirmPaymentIntentWebState();

  @override
  List<Object?> get props => [];
}

class ConfirmPaymentIntentWebInitial extends Initial
    implements ConfirmPaymentIntentWebState {
  const ConfirmPaymentIntentWebInitial() : super();

  @override
  List<Object?> get props => [];
}

class ConfirmPaymentIntentWebLoading extends Initial
    implements ConfirmPaymentIntentWebState {
  const ConfirmPaymentIntentWebLoading() : super();

  @override
  List<Object?> get props => [];
}

class ConfirmPaymentIntentWebSuccess extends Success
    implements ConfirmPaymentIntentWebState {
  final PaymentIntent paymentIntent;

  const ConfirmPaymentIntentWebSuccess({required this.paymentIntent});

  @override
  List<Object?> get props => [paymentIntent];
}

class ConfirmPaymentIntentWebStripeError extends Failure
    implements ConfirmPaymentIntentWebState {
  final StripeError stripeError;

  const ConfirmPaymentIntentWebStripeError({required this.stripeError});

  @override
  List<Object?> get props => [stripeError];
}

class ConfirmPaymentIntentWebStripeException extends Failure
    implements ConfirmPaymentIntentWebState {
  final StripeException exception;

  const ConfirmPaymentIntentWebStripeException({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class ConfirmPaymentIntentWebFailure extends Failure
    implements ConfirmPaymentIntentWebState {
  final dynamic exception;

  const ConfirmPaymentIntentWebFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class ConfirmPaymentIntentWebEmpty extends Failure
    implements ConfirmPaymentIntentWebState {
  const ConfirmPaymentIntentWebEmpty();

  @override
  List<Object?> get props => [];
}
