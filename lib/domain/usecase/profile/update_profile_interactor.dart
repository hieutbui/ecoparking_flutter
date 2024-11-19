import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/profile/profile_repository.dart';
import 'package:ecoparking_flutter/domain/state/profile/update_profile_state.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:ecoparking_flutter/pages/edit_profile/model/avatar_data.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateProfileInteractor with InteractorLoggy {
  final ProfileRepository _profileRepository = getIt.get<ProfileRepository>();

  Stream<Either<Failure, Success>> execute(
    Profile profile, {
    AvatarData? avatar,
  }) async* {
    try {
      yield const Right(UpdateProfileLoading());

      Profile profileToUpdate = profile;

      if (avatar != null) {
        final String avatarPath = await _profileRepository.uploadAvatarOnWeb(
          profile.id,
          avatar.bytes,
          avatar.fileExtension,
        );

        if (avatarPath.isNotEmpty) {
          final String avatarURL =
              await _profileRepository.createAvatarSignedURL(avatarPath);

          profileToUpdate = profile.copyWith(avatar: avatarURL);
        } else {
          loggy.error(
              'UpdateProfileInteractor::execute(): upload avatar failure');
          yield const Left(UpdateProfileFailure(
            exception: 'Create signed avatar URL failure',
          ));
          return;
        }
      }

      final Map<String, dynamic> response =
          await _profileRepository.updateProfile(profileToUpdate);

      final Profile updatedProfile = Profile.fromJson(response);

      loggy.info('UpdateProfileInteractor::execute(): update profile success');
      yield Right(UpdateProfileSuccess(profile: updatedProfile));
    } on StorageException catch (e) {
      loggy.error('UpdateProfileInteractor::execute(): storage failure: $e');
      yield Left(UpdateProfileStorageFailure(exception: e));
    } catch (e) {
      loggy.error(
          'UpdateProfileInteractor::execute(): update profile failure: $e');
      yield Left(UpdateProfileFailure(exception: e));
    }
  }
}
