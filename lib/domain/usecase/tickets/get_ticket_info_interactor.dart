import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/ticket/ticket_display.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_ticket_info_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class GetTicketInfoInteractor with InteractorLoggy {
  final TicketRepository _ticketRepository = getIt.get<TicketRepository>();

  Stream<Either<Failure, Success>> execute(String ticketId) async* {
    try {
      yield const Right(GetTicketInfoLoading());

      final ticket = await _ticketRepository.getTicketInfo(ticketId);

      if (ticket != null) {
        yield Right(
          GetTicketInfoSuccess(ticket: TicketDisplay.fromJson(ticket[0])),
        );
      } else {
        yield const Left(GetTicketInfoEmpty());
      }
    } catch (e) {
      loggy.error(e);
      yield Left(GetTicketInfoFailure(exception: e));
    }
  }
}
