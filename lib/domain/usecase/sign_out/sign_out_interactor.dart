import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/sign_out/sign_out_repository.dart';
import 'package:ecoparking_flutter/domain/state/sign_out/sign_out_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class SignOutInteractor with InteractorLoggy {
  final SignOutRepository _signOutRepository = getIt.get<SignOutRepository>();

  Stream<Either<Failure, Success>> execute() async* {
    try {
      yield const Right(SignOutInitial());

      await _signOutRepository.signOut();

      loggy.info('execute(): sign out success');
      yield const Right(SignOutSuccess());
    } catch (e) {
      loggy.error('execute(): sign out failure: $e');
      yield Left(SignOutFailure(exception: e));
    }
  }
}
