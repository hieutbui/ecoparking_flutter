import 'package:ecoparking_flutter/model/account/favorite_parking.dart';

abstract class UserFavoriteParkingsRepository {
  Future<List<FavoriteParking>?> fetchFavoriteParkings();
}
