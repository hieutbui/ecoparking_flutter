import 'package:ecoparking_flutter/data/datasource/search_parking/search_parking_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/search_parking/search_parking_repository.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_by.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_order.dart';
import 'package:geobase/geobase.dart';

class SearchParkingRepositoryImpl implements SearchParkingRepository {
  final SearchParkingDataSource _searchParkingDataSource =
      getIt.get<SearchParkingDataSource>();

  @override
  Future<List<dynamic>?> searchParking({
    String? searchQuery,
    Point? userLocation,
    double? maxDistance,
    ParkingSortBy? sortBy,
    ParkingSortOrder? sortOrder,
  }) {
    return _searchParkingDataSource.searchParking(
      searchQuery: searchQuery,
      userLocation: userLocation,
      maxDistance: maxDistance,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }
}
