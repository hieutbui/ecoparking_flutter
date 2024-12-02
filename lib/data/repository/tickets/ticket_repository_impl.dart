import 'package:ecoparking_flutter/data/datasource/tickets/ticket_datasource.dart';
import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketDataSource _ticketDataSource = getIt.get<TicketDataSource>();

  @override
  Future<List<dynamic>?> fetchOnGoingTickets() {
    return _ticketDataSource.fetchOnGoingTickets();
  }

  @override
  Future<List<dynamic>?> fetchCompletedTickets() {
    return _ticketDataSource.fetchCompletedTickets();
  }

  @override
  Future<List<dynamic>?> fetchCancelledTickets() {
    return _ticketDataSource.fetchCancelledTickets();
  }

  @override
  Future<Map<String, dynamic>?> createTicket(CreateTicketRequestData ticket) {
    return _ticketDataSource.createTicket(ticket);
  }

  @override
  Future<List<dynamic>?> getTicketInfo(String ticketId) {
    return _ticketDataSource.getTicketInfo(ticketId);
  }
}
