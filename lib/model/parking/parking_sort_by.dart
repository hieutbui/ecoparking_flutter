enum ParkingSortBy {
  price,
  distance;

  @override
  String toString() {
    switch (this) {
      case ParkingSortBy.price:
        return 'price';
      case ParkingSortBy.distance:
        return 'distance';
    }
  }

  String get name {
    switch (this) {
      case ParkingSortBy.price:
        return 'Giá';
      case ParkingSortBy.distance:
        return 'Khoảng cách';
    }
  }
}
