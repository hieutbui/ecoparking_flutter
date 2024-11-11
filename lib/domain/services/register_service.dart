import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterService {
  Session? _session;
  User? _user;

  Session? get session => _session;
  User? get user => _user;

  void setSession(Session session) {
    _session = session;
  }

  void setUser(User user) {
    _user = user;
  }

  void clear() {
    _session = null;
    _user = null;
  }
}
