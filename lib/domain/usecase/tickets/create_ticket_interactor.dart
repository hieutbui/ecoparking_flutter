import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';
import 'package:ecoparking_flutter/domain/state/tickets/create_ticket_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class CreateTicketInteractor with InteractorLoggy {
  final TicketRepository _ticketRepository = getIt.get<TicketRepository>();

  Stream<Either<Failure, Success>> execute(
    CreateTicketRequestData ticket,
  ) async* {
    try {
      yield const Right(CreateTicketLoading());

      final result = await _ticketRepository.createTicket(ticket);
      if (result != null) {
        yield Right(
          CreateTicketSuccess(
            ticket: CreateTicketRequestData.fromJson(result),
          ),
        );
      } else {
        yield const Left(CreateTicketEmpty());
      }
    } catch (e) {
      loggy.error(e);
      yield Left(CreateTicketFailure(exception: e));
    }
  }
}
