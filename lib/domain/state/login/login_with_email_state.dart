import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginWithEmailState with EquatableMixin {
  const LoginWithEmailState();

  @override
  List<Object?> get props => [];
}

class LoginWithEmailInitial extends Initial implements LoginWithEmailState {
  const LoginWithEmailInitial() : super();

  @override
  List<Object?> get props => [];
}

class LoginWithEmailSuccess extends Success implements LoginWithEmailInitial {
  final AuthResponse authResponse;

  const LoginWithEmailSuccess({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class LoginWithEmailEmptyAuth extends Failure implements LoginWithEmailInitial {
  const LoginWithEmailEmptyAuth();

  @override
  List<Object?> get props => [];
}

class LoginWithEmailOtherFailure extends Failure
    implements LoginWithEmailInitial {
  final dynamic exception;

  const LoginWithEmailOtherFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class LoginWithEmailAuthFailure extends Failure
    implements LoginWithEmailInitial {
  final AuthException exception;

  const LoginWithEmailAuthFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
