import 'package:ecoparking_flutter/model/account/favorite_parkings.dart';

abstract class UserFavoriteParkingsDatasource {
  Future<List<FavoriteParkings>?> fetchFavoriteParkings();
}
