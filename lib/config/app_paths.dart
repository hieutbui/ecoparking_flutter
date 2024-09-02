enum AppPaths {
  home,
  saved,
  booking,
  profile;

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
      default:
        return 'Home';
    }
  }
}
