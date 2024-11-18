import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/profile/profile_repository.dart';
import 'package:ecoparking_flutter/domain/state/profile/get_profile_state.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class GetProfileInteractor with InteractorLoggy {
  final ProfileRepository _profileRepository = getIt.get<ProfileRepository>();

  Stream<Either<Failure, Success>> execute(String id) async* {
    try {
      yield const Right(GetProfileInitial());

      final Map<String, dynamic> response =
          await _profileRepository.getProfile(id);

      final Profile profile = Profile.fromJson(response);

      loggy.info('execute(): get profile success');
      yield Right(GetProfileSuccess(profile: profile));
    } catch (e) {
      loggy.error('execute(): get profile failure: $e');
      yield Left(GetProfileFailure(exception: e));
    }
  }
}
