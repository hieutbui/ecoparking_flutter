import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';
import 'package:equatable/equatable.dart';

abstract class GetUserTicketsState with EquatableMixin {
  const GetUserTicketsState();

  @override
  List<Object?> get props => [];
}

class GetUserTicketsInitial extends Initial implements GetUserTicketsState {
  const GetUserTicketsInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetUserTicketsSuccess extends Success implements GetUserTicketsState {
  final List<Ticket> tickets;

  const GetUserTicketsSuccess({required this.tickets});

  @override
  List<Object?> get props => [tickets];
}

class GetUserTicketsIsEmpty extends Success implements GetUserTicketsState {
  const GetUserTicketsIsEmpty();

  @override
  List<Object?> get props => [];
}

class GetUserTicketsFailure extends Failure implements GetUserTicketsState {
  final dynamic exception;

  const GetUserTicketsFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
