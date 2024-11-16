enum AppPaths {
  login,
  register,
  registerVerify,
  home,
  saved,
  booking,
  profile,
  parkingDetails,
  bookingDetails,
  selectVehicle,
  reviewSummary,
  paymentMethod,
  editProfile;

  String get path {
    switch (this) {
      case AppPaths.login:
        return '/login';
      case AppPaths.register:
        return '/register';
      case AppPaths.registerVerify:
        return 'register-verify';
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
      case AppPaths.editProfile:
        return 'edit-profile';
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
      case AppPaths.registerVerify:
        return '/register/register-verify';
      case AppPaths.home:
        return '/home';
      case AppPaths.saved:
        return '/saved';
      case AppPaths.booking:
        return '/booking';
      case AppPaths.profile:
        return '/profile';
      case AppPaths.editProfile:
        return '/profile/edit-profile';
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
      case AppPaths.registerVerify:
        return 'Verify Your Account';
      case AppPaths.home:
        return 'Home';
      case AppPaths.saved:
        return 'Saved';
      case AppPaths.booking:
        return 'Booking';
      case AppPaths.profile:
        return 'Profile';
      case AppPaths.editProfile:
        return 'Edit Profile';
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

  String getTitle({ProfileType? profileType}) {
    switch (this) {
      case AppPaths.login:
        return 'Login to your Account';
      case AppPaths.register:
        return 'Create Your Account';
      case AppPaths.registerVerify:
        return 'Verify Your Account';
      case AppPaths.home:
        return 'Home';
      case AppPaths.saved:
        return 'My Bookmark';
      case AppPaths.booking:
        return 'My Ticket';
      case AppPaths.profile:
        return profileType?.title ?? 'Profile';
      case AppPaths.editProfile:
        return 'Edit Profile';
      case AppPaths.parkingDetails:
        return 'Parking Details';
      case AppPaths.bookingDetails:
        return 'Booking Parking Details';
      case AppPaths.selectVehicle:
        return 'Select Your Vehicle';
      case AppPaths.reviewSummary:
        return 'Review Summary';
      case AppPaths.paymentMethod:
        return 'Payment';
      default:
        return 'Home';
    }
  }
}

enum ProfileType {
  noAccount,
  hasAccount;

  String get title {
    switch (this) {
      case ProfileType.noAccount:
        return 'Let’s you in';
      case ProfileType.hasAccount:
        return 'Profile';
      default:
        return 'Profile';
    }
  }
}
