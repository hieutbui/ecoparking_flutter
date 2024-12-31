enum ParkingBottomSheetAction {
  bookNow,
  details;

  String get label {
    switch (this) {
      case ParkingBottomSheetAction.bookNow:
        return 'Đặt ngay';
      case ParkingBottomSheetAction.details:
        return 'Chi tiết';
    }
  }
}
