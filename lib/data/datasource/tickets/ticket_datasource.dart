import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';

abstract class TicketDataSource {
  Future<List<dynamic>?> fetchOnGoingTickets();
  Future<List<dynamic>?> fetchCompletedTickets();
  Future<List<dynamic>?> fetchCancelledTickets();
  Future<Map<String, dynamic>?> createTicket(CreateTicketRequestData ticket);
  Future<List<dynamic>?> getTicketInfo(String ticketId);
}
