import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/profile/profile_repository.dart';
import 'package:ecoparking_flutter/domain/state/profile/update_profile_state.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class UpdateProfileInteractor with InteractorLoggy {
  final ProfileRepository _profileRepository = getIt.get<ProfileRepository>();

  Stream<Either<Failure, Success>> execute(Profile profile) async* {
    try {
      yield const Right(UpdateProfileInitial());

      final Map<String, dynamic> response =
          await _profileRepository.updateProfile(profile);

      final Profile updatedProfile = Profile.fromJson(response);

      loggy.info('execute(): update profile success');
      yield Right(UpdateProfileSuccess(profile: updatedProfile));
    } catch (e) {
      loggy.error('execute(): update profile failure: $e');
      yield Left(UpdateProfileFailure(exception: e));
    }
  }
}
