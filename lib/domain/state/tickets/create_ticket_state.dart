import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:equatable/equatable.dart';

class CreateTicketState with EquatableMixin {
  const CreateTicketState();

  @override
  List<Object?> get props => [];
}

class CreateTicketInitial extends Initial implements CreateTicketState {
  const CreateTicketInitial() : super();

  @override
  List<Object?> get props => [];
}

class CreateTicketLoading extends Initial implements CreateTicketState {
  const CreateTicketLoading() : super();

  @override
  List<Object?> get props => [];
}

class CreateTicketSuccess extends Success implements CreateTicketState {
  final CreateTicketRequestData ticket;

  const CreateTicketSuccess({required this.ticket});

  @override
  List<Object?> get props => [ticket];
}

class CreateTicketFailure extends Failure implements CreateTicketState {
  final dynamic exception;

  const CreateTicketFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class CreateTicketEmpty extends Failure implements CreateTicketState {
  const CreateTicketEmpty();

  @override
  List<Object?> get props => [];
}
