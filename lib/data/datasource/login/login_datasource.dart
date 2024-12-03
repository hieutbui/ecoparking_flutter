import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginDataSource {
  Future<AuthResponse> loginWithEmail(String email, String password);
  Future<String?> getGoogleWebClient();
}
