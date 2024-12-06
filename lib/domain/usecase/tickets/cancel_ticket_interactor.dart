import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/ticket/cancel_ticket_response.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';
import 'package:ecoparking_flutter/domain/state/tickets/cancel_ticket_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class CancelTicketInteractor with InteractorLoggy {
  final TicketRepository _ticketRepository = getIt.get<TicketRepository>();

  Stream<Either<Failure, Success>> execute(String ticketId) async* {
    try {
      yield const Right(CancelTicketLoading());
      final response = await _ticketRepository.cancelTicket(ticketId);

      if (response.isEmpty) {
        yield const Left(CancelTicketEmpty());
        return;
      }

      CancelTicketResponse value;

      switch (response) {
        case 'ok':
          value = CancelTicketResponse.ok;
          break;
        case 'failed':
          value = CancelTicketResponse.failed;
          break;
        default:
          value = CancelTicketResponse.unknown;
          break;
      }

      yield Right(CancelTicketSuccess(response: value));
      return;
    } catch (e) {
      loggy.error('Error cancelling ticket: $e');
      yield Left(CancelTicketFailure(exception: e));
    }
  }
}
