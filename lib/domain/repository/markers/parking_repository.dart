import 'package:ecoparking_flutter/model/parking/parking.dart';

abstract class ParkingRepository {
  Future<Parking> fetchParking();
}
