import 'package:ecoparking_flutter/model/ticket/ticket.dart';

abstract class TicketRepository {
  Future<List<Ticket>?> fetchTickets();
  Future<List<Ticket>?> fetchOnGoingTickets();
  Future<List<Ticket>?> fetchCompletedTickets();
  Future<List<Ticket>?> fetchCancelledTickets();
}
