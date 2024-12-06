import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:geobase/geobase.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingDataSource _parkingsDataSource = getIt.get<ParkingDataSource>();

  @override
  Future<List<dynamic>?> findNearbyParkings(
    Point userLocation,
    double searchDistance,
  ) {
    return _parkingsDataSource.findNearbyParkings(userLocation, searchDistance);
  }

  @override
  Future<Map<String, dynamic>?> addFavoriteParking({
    required String userId,
    required String parkingId,
  }) {
    return _parkingsDataSource.addFavoriteParking(
      userId: userId,
      parkingId: parkingId,
    );
  }

  @override
  Future<Map<String, dynamic>?> removeFavoriteParking({
    required String userId,
    required String parkingId,
  }) {
    return _parkingsDataSource.removeFavoriteParking(
      userId: userId,
      parkingId: parkingId,
    );
  }
}
