abstract class TicketRepository {
  Future<List<dynamic>?> fetchOnGoingTickets();
  Future<List<dynamic>?> fetchCompletedTickets();
  Future<List<dynamic>?> fetchCancelledTickets();
}
