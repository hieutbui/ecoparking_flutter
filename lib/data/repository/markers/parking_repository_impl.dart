import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingDataSource parkingsDataSource = getIt.get<ParkingDataSource>();

  @override
  Future<List<Parking>?> fetchParkings() {
    return parkingsDataSource.fetchParkings();
  }
}
