enum TicketStatus {
  active,
  paid,
  completed,
  cancelled;

  String get name {
    switch (this) {
      case TicketStatus.active:
        return 'Now Active';
      case TicketStatus.paid:
        return 'Paid';
      case TicketStatus.completed:
        return 'Completed';
      case TicketStatus.cancelled:
        return 'Cancelled';
    }
  }
}
