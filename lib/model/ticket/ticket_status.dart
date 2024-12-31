enum TicketStatus {
  active,
  paid,
  completed,
  cancelled;

  String get name {
    switch (this) {
      case TicketStatus.active:
        return 'Đang hoạt động';
      case TicketStatus.paid:
        return 'Đã thanh toán';
      case TicketStatus.completed:
        return 'Hoan tất';
      case TicketStatus.cancelled:
        return 'Đã hủy';
    }
  }
}
