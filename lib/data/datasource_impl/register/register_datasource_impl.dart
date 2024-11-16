import 'package:ecoparking_flutter/data/datasource/register/register_datasource.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterDataSourceImpl implements RegisterDataSource {
  @override
  Future<AuthResponse> register(String email, String password) {
    return SupabaseUtils().client.auth.signUp(
          password: password,
          email: email,
        );
  }

  @override
  Future<AuthResponse> verifyRegistrationWithEmailOTP(
    String email,
    String token,
  ) {
    return SupabaseUtils().client.auth.verifyOTP(
          type: OtpType.signup,
          email: email,
          token: token,
        );
  }
}
