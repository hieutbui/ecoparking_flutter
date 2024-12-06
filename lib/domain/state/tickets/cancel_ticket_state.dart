import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/ticket/cancel_ticket_response.dart';
import 'package:equatable/equatable.dart';

class CancelTicketState with EquatableMixin {
  const CancelTicketState();

  @override
  List<Object?> get props => [];
}

class CancelTicketInitial extends Initial implements CancelTicketState {
  const CancelTicketInitial();

  @override
  List<Object?> get props => [];
}

class CancelTicketLoading extends Initial implements CancelTicketState {
  const CancelTicketLoading();

  @override
  List<Object?> get props => [];
}

class CancelTicketSuccess extends Success implements CancelTicketState {
  final CancelTicketResponse response;

  const CancelTicketSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class CancelTicketFailure extends Failure implements CancelTicketState {
  final dynamic exception;

  const CancelTicketFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class CancelTicketEmpty extends Failure implements CancelTicketState {
  const CancelTicketEmpty();

  @override
  List<Object?> get props => [];
}
