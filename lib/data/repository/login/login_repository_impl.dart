import 'package:ecoparking_flutter/data/datasource/login/login_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/login/login_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource = getIt.get<LoginDataSource>();

  @override
  Future<AuthResponse> loginWithEmail(String email, String password) {
    return _loginDataSource.loginWithEmail(email, password);
  }

  @override
  Future<String?> getGoogleWebClient() {
    return _loginDataSource.getGoogleWebClient();
  }
}
