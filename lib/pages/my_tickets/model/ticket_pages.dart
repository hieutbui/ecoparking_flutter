enum TicketPages {
  onGoing,
  completed,
  cancelled;

  String get name {
    switch (this) {
      case TicketPages.onGoing:
        return 'On Going';
      case TicketPages.completed:
        return 'Completed';
      case TicketPages.cancelled:
        return 'Cancelled';
    }
  }

  int get pageIndex {
    switch (this) {
      case TicketPages.onGoing:
        return 0;
      case TicketPages.completed:
        return 1;
      case TicketPages.cancelled:
        return 2;
    }
  }
}
