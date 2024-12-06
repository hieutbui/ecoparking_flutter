import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/user_vehicles/user_vehicles_repository.dart';
import 'package:ecoparking_flutter/domain/state/vehicles/add_new_vehicle_state.dart';
import 'package:ecoparking_flutter/model/account/vehicle.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class AddNewVehicleInteractor with InteractorLoggy {
  final UserVehiclesRepository _userVehiclesRepository =
      getIt.get<UserVehiclesRepository>();

  Stream<Either<Failure, Success>> execute({
    required String name,
    required String licensePlate,
    required String userId,
  }) async* {
    try {
      yield const Right(AddNewVehicleLoading());

      final vehicleJson = await _userVehiclesRepository.addUserVehicle(
        name: name,
        licensePlate: licensePlate,
        userId: userId,
      );

      if (vehicleJson == null) {
        loggy.error('execute(): vehicleJson is null');
        yield const Left(AddNewVehicleIsEmpty());
        return;
      }

      loggy.info('execute(): add new vehicle success');
      yield Right(AddNewVehicleSuccess(vehicle: Vehicle.fromJson(vehicleJson)));
      return;
    } catch (e) {
      loggy.error('execute(): add new vehicle failure: $e');
      yield Left(AddNewVehicleFailure(exception: e));
    }
  }
}
