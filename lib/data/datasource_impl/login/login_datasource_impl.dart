import 'package:ecoparking_flutter/data/datasource/login/login_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/database_functions_name.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<AuthResponse> loginWithEmail(String email, String password) {
    return SupabaseUtils().client.auth.signInWithPassword(
          email: email,
          password: password,
        );
  }

  @override
  Future<String?> getGoogleWebClient() {
    return SupabaseUtils().client.rpc(
          DatabaseFunctionsName.getGoogleWebClient.functionName,
        );
  }
}
