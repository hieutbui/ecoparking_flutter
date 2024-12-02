import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/ticket/ticket_display.dart';
import 'package:equatable/equatable.dart';

abstract class GetTicketInfoState with EquatableMixin {
  const GetTicketInfoState();

  @override
  List<Object?> get props => [];
}

class GetTicketInfoInitial extends Initial implements GetTicketInfoState {
  const GetTicketInfoInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetTicketInfoLoading extends Initial implements GetTicketInfoState {
  const GetTicketInfoLoading() : super();

  @override
  List<Object?> get props => [];
}

class GetTicketInfoSuccess extends Success implements GetTicketInfoState {
  final TicketDisplay ticket;

  const GetTicketInfoSuccess({required this.ticket}) : super();

  @override
  List<Object?> get props => [ticket];
}

class GetTicketInfoFailure extends Failure implements GetTicketInfoState {
  final dynamic exception;

  const GetTicketInfoFailure({required this.exception}) : super();

  @override
  List<Object?> get props => [exception];
}

class GetTicketInfoEmpty extends Failure implements GetTicketInfoState {
  const GetTicketInfoEmpty() : super();

  @override
  List<Object?> get props => [];
}
