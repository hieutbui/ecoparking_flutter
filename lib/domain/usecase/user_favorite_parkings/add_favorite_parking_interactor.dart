import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/parking/add_favorite_parking_response.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/add_favorite_parking_state.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';

class AddFavoriteParkingInteractor with InteractorLoggy {
  final ParkingRepository _parkingRepository = getIt.get<ParkingRepository>();

  Stream<Either<Failure, Success>> execute({
    required String userId,
    required String parkingId,
  }) async* {
    try {
      yield const Right(AddFavoriteParkingLoading());
      final response = await _parkingRepository.addFavoriteParking(
        userId: userId,
        parkingId: parkingId,
      );
      if (response == null) {
        yield const Left(AddFavoriteParkingEmpty());
        return;
      }

      yield Right(
        AddFavoriteParkingSuccess(
          response: AddFavoriteParkingResponse.fromJson(response),
        ),
      );
    } catch (e) {
      loggy.error('execute(): add favorite parking failure: $e');
      yield Left(AddFavoriteParkingFailure(exception: e));
      return;
    }
  }
}
