import 'package:ecoparking_flutter/config/dummy_data.dart';
import 'package:ecoparking_flutter/data/datasource/user_vehicles/user_vehicles_datasource.dart';
import 'package:ecoparking_flutter/model/account/vehicle.dart';

class UserVehiclesDatasourceImpl implements UserVehiclesDatasource {
  @override
  Future<List<Vehicle>?> fetchUserVehicles() async {
    await Future.delayed(const Duration(seconds: 2));

    return DummyData.vehicles;
  }
}
