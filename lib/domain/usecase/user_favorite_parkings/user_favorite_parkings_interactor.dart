import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/user_favorite_parkings/user_favorite_parkings_repository.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/get_user_favorite_parkings.dart';
import 'package:ecoparking_flutter/model/account/favorite_parking.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class UserFavoriteParkingsInteractor with InteractorLoggy {
  final UserFavoriteParkingsRepository _userFavoriteParkingsRepository =
      getIt.get<UserFavoriteParkingsRepository>();

  Stream<Either<Failure, Success>> execute(List<String> favorite) async* {
    try {
      yield const Right(GetUserFavoriteParkingsInitial());

      final favoriteParkingsJson =
          await _userFavoriteParkingsRepository.fetchFavoriteParkings(favorite);

      final List<FavoriteParking>? favoriteParkings = favoriteParkingsJson
          ?.map((e) => FavoriteParking.fromJson(e))
          .toList();

      if (favoriteParkings == null || favoriteParkings.isEmpty) {
        loggy.error('execute(): favorite parkings is null');
        yield const Right(GetUserFavoriteParkingsIsEmpty());
      } else {
        loggy.info('execute(): get favorite parkings success');
        yield Right(
            GetUserFavoriteParkingsSuccess(favoriteParkings: favoriteParkings));
      }
      return;
    } catch (e) {
      loggy.error('execute(): get favorite parkings failure: $e');
      yield Left(GetUserFavoriteParkingsFailure(exception: e));
      return;
    }
  }
}
