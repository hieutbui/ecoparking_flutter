import 'package:ecoparking_flutter/config/dummy_data.dart';
import 'package:ecoparking_flutter/data/datasource/tickets/ticket_datasource.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';

class TicketDataSourceImpl implements TicketDataSource {
  @override
  Future<List<Ticket>?> fetchTickets() async {
    await Future.delayed(const Duration(seconds: 2));

    //TODO: Implement fetching data from API
    return DummyData.tickets;
  }

  @override
  Future<List<Ticket>?> fetchOnGoingTickets() async {
    await Future.delayed(const Duration(seconds: 2));

    return DummyData.onGoingTickets;
  }

  @override
  Future<List<Ticket>?> fetchCompletedTickets() async {
    await Future.delayed(const Duration(seconds: 2));

    return DummyData.completedTickets;
  }

  @override
  Future<List<Ticket>?> fetchCancelledTickets() async {
    await Future.delayed(const Duration(seconds: 2));

    return DummyData.cancelledTickets;
  }
}
