import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/register/register_repository.dart';
import 'package:ecoparking_flutter/domain/state/register/verify_email_otp.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyEmailOtpInteractor with InteractorLoggy {
  final RegisterRepository _registerRepository =
      getIt.get<RegisterRepository>();

  Stream<Either<Failure, Success>> execute(
    String email,
    String token,
  ) async* {
    try {
      yield const Right(VerifyEmailOtpLoading());

      final AuthResponse authResponse = await _registerRepository
          .verifyRegistrationWithEmailOTP(email, token);

      if (authResponse.user != null) {
        loggy.info('execute(): verify email otp success');
        yield Right(VerifyEmailOtpSuccess(authResponse: authResponse));
      } else {
        loggy.error('execute(): verify email otp failure');
        yield const Left(VerifyEmailOtpEmptyAuth());
      }
    } on AuthException catch (e) {
      loggy.error('execute(): verify email otp failure: $e');
      yield Left(VerifyEmailOtpAuthFailure(exception: e));
    } catch (e) {
      loggy.error('execute(): verify email otp failure: $e');
      yield Left(VerifyEmailOtpOtherFailure(exception: e));
    }
  }
}
