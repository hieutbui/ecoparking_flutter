import 'package:ecoparking_flutter/model/account/vehicle.dart';

abstract class UserVehiclesDatasource {
  Future<List<Vehicle>?> fetchUserVehicles();
}
