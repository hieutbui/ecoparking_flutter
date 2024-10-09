import 'package:ecoparking_flutter/model/account/vehicle.dart';

abstract class UserVehiclesRepository {
  Future<List<Vehicle>?> fetchUserVehicles();
}
