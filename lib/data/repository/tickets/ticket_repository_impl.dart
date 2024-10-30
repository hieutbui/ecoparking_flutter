import 'package:ecoparking_flutter/data/datasource/tickets/ticket_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketDataSource ticketDataSource = getIt.get<TicketDataSource>();

  @override
  Future<List<Ticket>?> fetchTickets() {
    return ticketDataSource.fetchTickets();
  }

  @override
  Future<List<Ticket>?> fetchOnGoingTickets() {
    return ticketDataSource.fetchOnGoingTickets();
  }

  @override
  Future<List<Ticket>?> fetchCompletedTickets() {
    return ticketDataSource.fetchCompletedTickets();
  }

  @override
  Future<List<Ticket>?> fetchCancelledTickets() {
    return ticketDataSource.fetchCancelledTickets();
  }
}
