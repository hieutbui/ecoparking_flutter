import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:equatable/equatable.dart';

abstract class GetGoogleWebClientState with EquatableMixin {
  const GetGoogleWebClientState();

  @override
  List<Object?> get props => [];
}

class GetGoogleWebClientInitial extends Initial
    implements GetGoogleWebClientState {
  const GetGoogleWebClientInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetGoogleWebClientLoading extends Initial
    implements GetGoogleWebClientState {
  const GetGoogleWebClientLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetGoogleWebClientSuccess extends Success
    implements GetGoogleWebClientState {
  final String googleWebClient;

  const GetGoogleWebClientSuccess({required this.googleWebClient});

  @override
  List<Object?> get props => [googleWebClient];
}

class GetGoogleWebClientFailure extends Failure
    implements GetGoogleWebClientState {
  final dynamic error;

  const GetGoogleWebClientFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetGoogleWebClientEmpty extends Failure
    implements GetGoogleWebClientState {
  const GetGoogleWebClientEmpty();

  @override
  List<Object?> get props => [];
}
