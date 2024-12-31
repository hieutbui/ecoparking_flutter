enum RegisterTypes {
  email,
  phone,
  google,
  facebook;

  String get verifyMessage {
    switch (this) {
      case RegisterTypes.phone:
        return 'Vui lòng kiểm tra tin nhắn chứa mã xác thực';
      case RegisterTypes.email:
      case RegisterTypes.google:
      case RegisterTypes.facebook:
        return 'Vui lòng kiểm tra email chứa mã xác thực';
    }
  }
}
