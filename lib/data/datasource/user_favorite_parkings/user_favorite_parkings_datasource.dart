import 'package:ecoparking_flutter/model/account/favorite_parking.dart';

abstract class UserFavoriteParkingsDatasource {
  Future<List<FavoriteParking>?> fetchFavoriteParkings();
}
