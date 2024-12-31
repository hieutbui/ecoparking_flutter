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
  editProfile,
  ticketDetails,
  testPage;

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
      case AppPaths.ticketDetails:
        return 'ticket-details';
      case AppPaths.editProfile:
        return 'edit-profile';
      case AppPaths.testPage:
        return '/test-page';
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
      case AppPaths.ticketDetails:
        return '/booking/ticket-details';
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
      case AppPaths.testPage:
        return '/test-page';
      default:
        return '/home';
    }
  }

  String get label {
    switch (this) {
      case AppPaths.login:
        return 'Đăng nhập vào tài khoản của bạn';
      case AppPaths.register:
        return 'Tạo tài khoản của bạn';
      case AppPaths.registerVerify:
        return 'Xác nhận tài khoản của bạn';
      case AppPaths.home:
        return 'Trang chủ';
      case AppPaths.saved:
        return 'Yêu thích';
      case AppPaths.booking:
        return 'Vé';
      case AppPaths.profile:
        return 'Hồ sơ';
      case AppPaths.editProfile:
        return 'Chỉnh sửa hồ sơ';
      case AppPaths.parkingDetails:
        return 'Chi tiết bãi đỗ';
      case AppPaths.bookingDetails:
        return 'Chi tiết đặt chỗ';
      case AppPaths.selectVehicle:
        return 'Chọn xe của bạn';
      case AppPaths.reviewSummary:
        return 'Kiểm tra';
      case AppPaths.ticketDetails:
        return 'Chi tiết vé';
      case AppPaths.paymentMethod:
        return 'Phương thức thanh toán';
      case AppPaths.testPage:
        return 'Test Page';
      default:
        return 'Trang chủ';
    }
  }

  String getTitle({ProfileType? profileType}) {
    switch (this) {
      case AppPaths.login:
        return 'Đăng nhập vào tài khoản của bạn';
      case AppPaths.register:
        return 'Tạo tài khoản của bạn';
      case AppPaths.registerVerify:
        return 'Xác nhận tài khoản của bạn';
      case AppPaths.home:
        return 'Trang chủ';
      case AppPaths.saved:
        return 'Yêu thích';
      case AppPaths.booking:
        return 'Vé';
      case AppPaths.profile:
        return profileType?.title ?? 'Hồ sơ';
      case AppPaths.editProfile:
        return 'Chỉnh sửa hồ sơ';
      case AppPaths.parkingDetails:
        return 'Chi tiết bãi đỗ';
      case AppPaths.bookingDetails:
        return 'Chi tiết đặt chỗ';
      case AppPaths.selectVehicle:
        return 'Chọn xe của bạn';
      case AppPaths.reviewSummary:
        return 'Kiểm tra';
      case AppPaths.ticketDetails:
        return 'Chi tiết vé';
      case AppPaths.paymentMethod:
        return 'Phương thức thanh toán';
      case AppPaths.testPage:
        return 'Test Page';
      default:
        return 'Trang chủ';
    }
  }
}

enum ProfileType {
  noAccount,
  hasAccount;

  String get title {
    switch (this) {
      case ProfileType.noAccount:
        return 'Đăng ký';
      case ProfileType.hasAccount:
        return 'Hồ sơ';
      default:
        return 'Hồ sơ';
    }
  }
}
