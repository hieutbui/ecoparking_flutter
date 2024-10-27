enum ParkingBottomSheetAction {
  bookNow,
  details;

  String get label {
    switch (this) {
      case ParkingBottomSheetAction.bookNow:
        return 'Book Now';
      case ParkingBottomSheetAction.details:
        return 'Details';
    }
  }
}
