import 'package:ecoparking_flutter/model/account/favorite_parkings.dart';

abstract class UserFavoriteParkingsRepository {
  Future<List<FavoriteParkings>?> fetchFavoriteParkings();
}
