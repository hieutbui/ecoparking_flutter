import 'package:ecoparking_flutter/data/datasource/markers/current_location_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/current_location_repository.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationRepositoryImpl implements CurrentLocationRepository {
  final CurrentLocationDataSource currentLocationDataSource =
      getIt.get<CurrentLocationDataSource>();

  @override
  Future<Position?> fetchCurrentLocation() {
    return currentLocationDataSource.fetchCurrentLocation();
  }
}
