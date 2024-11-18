import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountService {
  Session? session;
  User? user;
  Profile? profile;

  void setSession(Session? session) {
    this.session = session;
  }

  void setUser(User? user) {
    this.user = user;
  }

  void setProfile(Profile? profile) {
    this.profile = profile;
  }

  void clear() {
    session = null;
    user = null;
    profile = null;
  }
}
