enum AppPaths {
  home,
  saved,
  booking,
  profile,
  parkingDetails;

  String get path {
    switch (this) {
      case AppPaths.home:
        return '/home';
      case AppPaths.saved:
        return '/saved';
      case AppPaths.booking:
        return '/booking';
      case AppPaths.profile:
        return '/profile';
      case AppPaths.parkingDetails:
        return '/parking-details';
      default:
        return '/home';
    }
  }

  String get label {
    switch (this) {
      case AppPaths.home:
        return 'Home';
      case AppPaths.saved:
        return 'Saved';
      case AppPaths.booking:
        return 'Booking';
      case AppPaths.profile:
        return 'Profile';
      case AppPaths.parkingDetails:
        return 'Parking Details';
      default:
        return 'Home';
    }
  }
}
