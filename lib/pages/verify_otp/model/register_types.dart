enum RegisterTypes {
  email,
  phone,
  google,
  facebook;

  String get verifyMessage {
    switch (this) {
      case RegisterTypes.phone:
        return 'Please check your phone for the verification code';
      case RegisterTypes.email:
      case RegisterTypes.google:
      case RegisterTypes.facebook:
        return 'Please check your email for the verification code';
    }
  }
}
