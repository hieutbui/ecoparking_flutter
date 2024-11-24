import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:geobase/geobase.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingDataSource parkingsDataSource = getIt.get<ParkingDataSource>();

  @override
  Future<List<dynamic>?> findNearbyParkings(
    Point userLocation,
    double searchDistance,
  ) {
    return parkingsDataSource.findNearbyParkings(userLocation, searchDistance);
  }
}
