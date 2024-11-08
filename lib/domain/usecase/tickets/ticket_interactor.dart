import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_user_tickets_state.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';
import 'package:ecoparking_flutter/pages/my_tickets/model/ticket_pages.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class TicketInteractor with InteractorLoggy {
  final TicketRepository _ticketRepository = getIt.get<TicketRepository>();

  Stream<Either<Failure, Success>> execute(TicketPages status) async* {
    try {
      yield const Right(GetUserTicketsInitial());

      List<Ticket>? tickets;

      switch (status) {
        case TicketPages.onGoing:
          tickets = await _ticketRepository.fetchOnGoingTickets();
          break;
        case TicketPages.completed:
          tickets = await _ticketRepository.fetchCompletedTickets();
          break;
        case TicketPages.cancelled:
          tickets = await _ticketRepository.fetchCancelledTickets();
          break;
        default:
          tickets = await _ticketRepository.fetchTickets();
          break;
      }

      if (tickets == null || tickets.isEmpty) {
        loggy.error('execute(): tickets is null');
        yield const Right(GetUserTicketsIsEmpty());
      } else {
        loggy.info('execute(): get tickets success');
        yield Right(GetUserTicketsSuccess(tickets: tickets));
      }
      return;
    } catch (e) {
      loggy.error('execute(): get tickets failure: $e');
      yield Left(GetUserTicketsFailure(exception: e));
    }
  }
}
