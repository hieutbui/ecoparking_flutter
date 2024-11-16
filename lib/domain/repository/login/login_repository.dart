import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRepository {
  Future<AuthResponse> loginWithEmail(String email, String password);
}
