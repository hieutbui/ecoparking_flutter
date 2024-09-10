import 'package:ecoparking_flutter/model/parking/parking.dart';

abstract class ParkingDataSource {
  Future<List<Parking>?> fetchParkings();
}
