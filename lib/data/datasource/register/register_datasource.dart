import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RegisterDataSource {
  Future<AuthResponse> register(String email, String password);
}
