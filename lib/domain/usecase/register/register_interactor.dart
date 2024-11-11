import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/register/register_repository.dart';
import 'package:ecoparking_flutter/domain/state/register/register_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterInteractor with InteractorLoggy {
  final RegisterRepository _registerRepository =
      getIt.get<RegisterRepository>();

  Stream<Either<Failure, Success>> execute(
    String email,
    String password,
  ) async* {
    try {
      yield const Right(RegisterInitial());

      final AuthResponse authResponse =
          await _registerRepository.register(email, password);

      if (authResponse.user != null) {
        loggy.info('execute(): register success');
        yield Right(RegisterSuccess(authResponse: authResponse));
      } else {
        loggy.error('execute(): register failure');
        yield const Left(RegisterEmptyAuth());
      }
    } on AuthException catch (e) {
      loggy.error('execute(): register failure: $e');
      yield Left(RegisterAuthFailure(exception: e));
    } catch (e) {
      loggy.error('execute(): register failure: $e');
      yield Left(RegisterOtherFailure(exception: e));
    }
  }
}
