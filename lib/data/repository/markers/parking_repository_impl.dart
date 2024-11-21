import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingDataSource parkingsDataSource = getIt.get<ParkingDataSource>();

  @override
  Future<List<Map<String, dynamic>>?> fetchParkings() {
    return parkingsDataSource.fetchParkings();
  }
}
