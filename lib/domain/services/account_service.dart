import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountService {
  Session? session;
  User? user;
  Profile? profile;
  String? googleWebClientId;

  void setSession(Session? session) {
    this.session = session;
  }

  void setUser(User? user) {
    this.user = user;
  }

  void setProfile(Profile? profile) {
    this.profile = profile;
  }

  void setGoogleWebClientId(String? googleWebClientId) {
    this.googleWebClientId = googleWebClientId;
  }

  void clear() {
    session = null;
    user = null;
    profile = null;
    googleWebClientId = null;
  }
}
