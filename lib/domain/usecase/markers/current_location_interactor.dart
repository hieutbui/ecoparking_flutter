import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/current_location_repository.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_current_location_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class CurrentLocationInteractor with InteractorLoggy {
  final CurrentLocationRepository _currentLocationRepository =
      getIt.get<CurrentLocationRepository>();

  Stream<Either<Failure, Success>> execute() async* {
    try {
      yield const Right(GetCurrentLocationInitial());

      final currentLocation =
          await _currentLocationRepository.fetchCurrentLocation();

      if (currentLocation == null) {
        loggy.error('execute(): current location is null');
        yield const Left(GetCurrentLocationIsEmpty());
      } else {
        loggy.info('execute(): get current location success');
        yield Right(
          GetCurrentLocationSuccess(currentLocation: currentLocation),
        );
      }
      return;
    } catch (e) {
      loggy.error('execute(): get current location failure: $e');
      yield Left(GetCurrentLocationFailure(exception: e));
    }
  }
}
