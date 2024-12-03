enum DatabaseFunctionsName {
  getOngoingTickets,
  getCompletedTickets,
  getCancelledTickets,
  getParkingWithShiftPrices,
  findNearbyParkings,
  searchParking,
  getTicketInfo,
  createPaymentIntent;

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
      case DatabaseFunctionsName.findNearbyParkings:
        return 'find_nearby_parkings';
      case DatabaseFunctionsName.searchParking:
        return 'search_parking';
      case DatabaseFunctionsName.getTicketInfo:
        return 'get_ticket_info';
      case DatabaseFunctionsName.createPaymentIntent:
        return 'create_payment_intent';
    }
  }
}
