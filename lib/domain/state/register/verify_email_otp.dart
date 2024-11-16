import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class VerifyEmailOtpState with EquatableMixin {
  const VerifyEmailOtpState();

  @override
  List<Object?> get props => [];
}

class VerifyEmailOtpLoading extends Initial implements VerifyEmailOtpState {
  const VerifyEmailOtpLoading();

  @override
  List<Object?> get props => [];
}

class VerifyEmailOtpInitial extends Initial implements VerifyEmailOtpState {
  const VerifyEmailOtpInitial() : super();

  @override
  List<Object?> get props => [];
}

class VerifyEmailOtpSuccess extends Success implements VerifyEmailOtpState {
  final AuthResponse authResponse;

  const VerifyEmailOtpSuccess({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class VerifyEmailOtpEmptyAuth extends Failure implements VerifyEmailOtpState {
  const VerifyEmailOtpEmptyAuth();

  @override
  List<Object?> get props => [];
}

class VerifyEmailOtpOtherFailure extends Failure
    implements VerifyEmailOtpState {
  final dynamic exception;

  const VerifyEmailOtpOtherFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class VerifyEmailOtpAuthFailure extends Failure implements VerifyEmailOtpState {
  final AuthException exception;

  const VerifyEmailOtpAuthFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
