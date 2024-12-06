import 'package:ecoparking_flutter/data/datasource/user_vehicles/user_vehicles_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/user_vehicles/user_vehicles_repository.dart';

class UserVehiclesRepositoryImpl implements UserVehiclesRepository {
  final UserVehiclesDataSource userVehiclesDataSource =
      getIt.get<UserVehiclesDataSource>();

  @override
  Future<List<Map<String, dynamic>>?> fetchUserVehicles() {
    return userVehiclesDataSource.fetchUserVehicles();
  }

  @override
  Future<Map<String, dynamic>?> addUserVehicle({
    required String name,
    required String licensePlate,
    required String userId,
  }) {
    return userVehiclesDataSource.addUserVehicle(
      name: name,
      licensePlate: licensePlate,
      userId: userId,
    );
  }
}
