import 'package:ecoparking_flutter/data/datasource/user_vehicles/user_vehicles_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/user_vehicles/user_vehicles_repository.dart';
import 'package:ecoparking_flutter/model/account/vehicle.dart';

class UserVehiclesRepositoryImpl implements UserVehiclesRepository {
  final UserVehiclesDatasource userVehiclesDatasource =
      getIt.get<UserVehiclesDatasource>();

  @override
  Future<List<Vehicle>?> fetchUserVehicles() {
    return userVehiclesDatasource.fetchUserVehicles();
  }
}
