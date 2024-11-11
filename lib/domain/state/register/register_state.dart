import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RegisterState with EquatableMixin {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends Initial implements RegisterState {
  const RegisterInitial() : super();

  @override
  List<Object?> get props => [];
}

class RegisterSuccess extends Success implements RegisterState {
  final AuthResponse authResponse;

  const RegisterSuccess({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class RegisterEmptyAuth extends Failure implements RegisterState {
  const RegisterEmptyAuth();

  @override
  List<Object?> get props => [];
}

class RegisterOtherFailure extends Failure implements RegisterState {
  final dynamic exception;

  const RegisterOtherFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class RegisterAuthFailure extends Failure implements RegisterState {
  final AuthException exception;

  const RegisterAuthFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
