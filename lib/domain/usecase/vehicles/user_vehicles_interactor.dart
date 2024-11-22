import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/user_vehicles/user_vehicles_repository.dart';
import 'package:ecoparking_flutter/domain/state/vehicles/get_user_vehicles_state.dart';
import 'package:ecoparking_flutter/model/account/vehicle.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class UserVehiclesInteractor with InteractorLoggy {
  final UserVehiclesRepository _userVehiclesRepository =
      getIt.get<UserVehiclesRepository>();

  Stream<Either<Failure, Success>> execute() async* {
    try {
      yield const Right(GetUserVehiclesInitial());

      final vehiclesJson = await _userVehiclesRepository.fetchUserVehicles();

      print('vehiclesJson: $vehiclesJson');

      if (vehiclesJson == null) {
        loggy.error('execute(): vehiclesJson is null');
        yield const Left(GetUserVehiclesIsEmpty());
        return;
      }

      final List<Vehicle> vehicles =
          vehiclesJson.map((e) => Vehicle.fromJson(e)).toList();

      if (vehicles.isEmpty) {
        loggy.error('execute(): vehicles is null');
        yield const Left(GetUserVehiclesIsEmpty());
      } else {
        loggy.info('execute(): get vehicles success');
        yield Right(GetUserVehiclesSuccess(vehicles: vehicles));
      }
      return;
    } catch (e) {
      loggy.error('execute(): get vehicles failure: $e');
      yield Left(GetUserVehiclesFailure(exception: e));
    }
  }
}
