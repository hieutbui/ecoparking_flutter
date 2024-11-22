import 'package:ecoparking_flutter/data/datasource/user_favorite_parkings/user_favorite_parkings_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/user_favorite_parkings/user_favorite_parkings_repository.dart';

class UserFavoriteParkingsRepositoryImpl
    implements UserFavoriteParkingsRepository {
  final UserFavoriteParkingsDatasource userFavoriteParkingsDatasource =
      getIt.get<UserFavoriteParkingsDatasource>();

  @override
  Future<List<Map<String, dynamic>>?> fetchFavoriteParkings(
    List<String> favoriteParkings,
  ) {
    return userFavoriteParkingsDatasource
        .fetchFavoriteParkings(favoriteParkings);
  }
}
