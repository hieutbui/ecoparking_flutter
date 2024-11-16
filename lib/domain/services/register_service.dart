import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterService {
  User? user;

  void setUser(User user) {
    this.user = user;
  }

  void clear() {
    user = null;
  }
}
