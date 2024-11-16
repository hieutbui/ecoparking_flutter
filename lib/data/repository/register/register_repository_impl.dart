import 'package:ecoparking_flutter/data/datasource/register/register_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/register/register_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSource _registerDataSource =
      getIt.get<RegisterDataSource>();

  @override
  Future<AuthResponse> register(String email, String password) {
    return _registerDataSource.register(email, password);
  }

  @override
  Future<AuthResponse> verifyRegistrationWithEmailOTP(
    String email,
    String token,
  ) {
    return _registerDataSource.verifyRegistrationWithEmailOTP(email, token);
  }
}
