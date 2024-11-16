import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RegisterDataSource {
  Future<AuthResponse> register(String email, String password);
  Future<AuthResponse> verifyRegistrationWithEmailOTP(
    String email,
    String token,
  );
}
