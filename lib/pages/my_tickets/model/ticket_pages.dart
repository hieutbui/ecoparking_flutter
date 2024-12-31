enum TicketPages {
  onGoing,
  completed,
  cancelled;

  String get name {
    switch (this) {
      case TicketPages.onGoing:
        return 'Hoạt động';
      case TicketPages.completed:
        return 'Hoàn thành';
      case TicketPages.cancelled:
        return 'Đã hủy';
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
