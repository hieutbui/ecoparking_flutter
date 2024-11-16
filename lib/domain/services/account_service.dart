import 'package:supabase_flutter/supabase_flutter.dart';

class AccountService {
  Session? session;
  User? user;

  void setSession(Session? session) {
    this.session = session;
  }

  void setUser(User? user) {
    this.user = user;
  }

  void clear() {
    session = null;
    user = null;
  }
}
