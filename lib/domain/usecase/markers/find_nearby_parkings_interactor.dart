import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:ecoparking_flutter/domain/state/markers/find_nearby_parkings_state.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:geobase/geobase.dart';

class FindNearbyParkingsInteractor with InteractorLoggy {
  final ParkingRepository _parkingRepository = getIt.get<ParkingRepository>();

  Stream<Either<Failure, Success>> execute(
    Point userLocation,
    double searchDistance,
  ) async* {
    try {
      yield const Right(FindNearbyParkingsLoading());

      final parkingsJSON = await _parkingRepository.findNearbyParkings(
        userLocation,
        searchDistance,
      );

      final List<Parking>? parkings =
          parkingsJSON?.map((parking) => Parking.fromJson(parking)).toList();

      if (parkings == null || parkings.isEmpty) {
        loggy.error('execute(): parkings is null');
        yield const Right(FindNearbyParkingsIsEmpty());
      } else {
        loggy.info('execute(): find nearby parkings success');
        yield Right(FindNearbyParkingsSuccess(parkings: parkings));
      }
    } catch (e) {
      loggy.error('execute(): find nearby parkings failure: $e');
      yield Left(FindNearbyParkingsFailure(exception: e));
    }
  }
}
