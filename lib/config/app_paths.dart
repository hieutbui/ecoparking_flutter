enum AppPaths {
  login,
  register,
  home,
  saved,
  booking,
  profile,
  parkingDetails,
  bookingDetails,
  selectVehicle,
  reviewSummary,
  paymentMethod;

  String get path {
    switch (this) {
      case AppPaths.login:
        return '/login';
      case AppPaths.register:
        return '/register';
      case AppPaths.home:
        return '/home';
      case AppPaths.saved:
        return '/saved';
      case AppPaths.booking:
        return '/booking';
      case AppPaths.profile:
        return '/profile';
      case AppPaths.parkingDetails:
        return 'parking-details';
      case AppPaths.bookingDetails:
        return 'booking-details';
      case AppPaths.selectVehicle:
        return 'select-vehicle';
      case AppPaths.reviewSummary:
        return 'review-summary';
      case AppPaths.paymentMethod:
        return 'payment-method';
      default:
        return '/home';
    }
  }

  String get navigationPath {
    switch (this) {
      case AppPaths.login:
        return '/login';
      case AppPaths.register:
        return '/register';
      case AppPaths.home:
        return '/home';
      case AppPaths.saved:
        return '/saved';
      case AppPaths.booking:
        return '/booking';
      case AppPaths.profile:
        return '/profile';
      case AppPaths.parkingDetails:
        return '/home/parking-details';
      case AppPaths.bookingDetails:
        return '/home/booking-details';
      case AppPaths.selectVehicle:
        return '/home/select-vehicle';
      case AppPaths.reviewSummary:
        return '/home/review-summary';
      case AppPaths.paymentMethod:
        return '/home/review-summary/payment-method';
      default:
        return '/home';
    }
  }

  String get label {
    switch (this) {
      case AppPaths.login:
        return 'Login to your Account';
      case AppPaths.register:
        return 'Create Your Account';
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
      case AppPaths.bookingDetails:
        return 'Booking Parking Details';
      case AppPaths.selectVehicle:
        return 'Select Vehicle';
      case AppPaths.reviewSummary:
        return 'Review Summary';
      case AppPaths.paymentMethod:
        return 'Select Payment Method';
      default:
        return 'Home';
    }
  }
}
