enum DatabaseFunctionsName {
  getOngoingTickets,
  getCompletedTickets,
  getCancelledTickets,
  getParkingWithShiftPrices;

  String get functionName {
    switch (this) {
      case DatabaseFunctionsName.getOngoingTickets:
        return 'get_ongoing_tickets';
      case DatabaseFunctionsName.getCompletedTickets:
        return 'get_completed_tickets';
      case DatabaseFunctionsName.getCancelledTickets:
        return 'get_cancelled_tickets';
      case DatabaseFunctionsName.getParkingWithShiftPrices:
        return 'get_parking_with_shift_prices';
    }
  }
}
