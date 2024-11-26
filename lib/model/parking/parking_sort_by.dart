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
        return 'Price';
      case ParkingSortBy.distance:
        return 'Distance';
    }
  }
}
