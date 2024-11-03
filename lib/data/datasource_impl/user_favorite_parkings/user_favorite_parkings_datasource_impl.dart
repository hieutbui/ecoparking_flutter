import 'package:ecoparking_flutter/config/dummy_data.dart';
import 'package:ecoparking_flutter/data/datasource/user_favorite_parkings/user_favorite_parkings_datasource.dart';
import 'package:ecoparking_flutter/model/account/favorite_parking.dart';

class UserFavoriteParkingsDatasourceImpl
    implements UserFavoriteParkingsDatasource {
  @override
  Future<List<FavoriteParking>?> fetchFavoriteParkings() async {
    await Future.delayed(const Duration(seconds: 2));

    //TODO: Implement fetching data from API
    return DummyData.favoriteParkings;
  }
}
