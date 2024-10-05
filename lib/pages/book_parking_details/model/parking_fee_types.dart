enum ParkingFeeTypes {
  hourly,
  daily,
  monthly,
  annually;

  int get tabIndex {
    switch (this) {
      case ParkingFeeTypes.hourly:
        return 0;
      case ParkingFeeTypes.daily:
      case ParkingFeeTypes.monthly:
      case ParkingFeeTypes.annually:
        return 1;
    }
  }
}
