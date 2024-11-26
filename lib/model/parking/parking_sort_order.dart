enum ParkingSortOrder {
  ascending,
  descending;

  @override
  String toString() {
    switch (this) {
      case ParkingSortOrder.ascending:
        return 'asc';
      case ParkingSortOrder.descending:
        return 'desc';
    }
  }

  String get name {
    switch (this) {
      case ParkingSortOrder.ascending:
        return 'Ascending';
      case ParkingSortOrder.descending:
        return 'Descending';
    }
  }
}
