import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/login/login_repository.dart';
import 'package:ecoparking_flutter/domain/state/login/get_google_web_client_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class GetGoogleWebClientInteractor with InteractorLoggy {
  final LoginRepository _loginRepository = getIt.get<LoginRepository>();

  Stream<Either<Failure, Success>> execute() async* {
    try {
      yield const Right(GetGoogleWebClientLoading());

      final String? googleWebClient =
          await _loginRepository.getGoogleWebClient();

      if (googleWebClient != null) {
        yield Right(
          GetGoogleWebClientSuccess(
            googleWebClient: googleWebClient,
          ),
        );
      } else {
        yield const Left(GetGoogleWebClientEmpty());
      }
    } catch (e) {
      loggy.error(
          'GetGoogleWebClientInteractor::execute(): get google web client failure: $e');
      yield Left(GetGoogleWebClientFailure(error: e));
    }
  }
}
