import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/login/login_repository.dart';
import 'package:ecoparking_flutter/domain/state/login/login_with_email_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginWithEmailInteractor with InteractorLoggy {
  final LoginRepository _loginRepository = getIt.get<LoginRepository>();

  Stream<Either<Failure, Success>> execute(
    String email,
    String password,
  ) async* {
    try {
      final AuthResponse authResponse =
          await _loginRepository.loginWithEmail(email, password);

      if (authResponse.user != null) {
        loggy.info('execute(): login success');
        yield Right(LoginWithEmailSuccess(authResponse: authResponse));
      } else {
        loggy.error('execute(): login failure');
        yield const Left(LoginWithEmailEmptyAuth());
      }
    } on AuthException catch (e) {
      loggy.error('execute(): login failure: $e');
      yield Left(LoginWithEmailAuthFailure(exception: e));
    } catch (e) {
      loggy.error('execute(): login failure: $e');
      yield Left(LoginWithEmailOtherFailure(exception: e));
    }
  }
}
