import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_parkings_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class ParkingInteractor with InteractorLoggy {
  final ParkingRepository _parkingRepository = getIt.get<ParkingRepository>();

  Stream<Either<Failure, Success>> execute() async* {
    try {
      yield const Right(GetParkingsInitial());

      final parkings = await _parkingRepository.fetchParkings();

      if (parkings == null) {
        loggy.error('execute(): parkings is null');
        yield const Right(GetParkingsIsEmpty());
      } else {
        loggy.info('execute(): get parkings success');
        yield Right(GetParkingsSuccess(parkings: parkings));
      }
      return;
    } catch (e) {
      loggy.error('execute(): get parkings failure: $e');
      yield Left(GetParkingsFailure(exception: e));
    }
  }
}
