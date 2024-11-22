abstract class TicketDataSource {
  Future<List<dynamic>?> fetchOnGoingTickets();
  Future<List<dynamic>?> fetchCompletedTickets();
  Future<List<dynamic>?> fetchCancelledTickets();
}
