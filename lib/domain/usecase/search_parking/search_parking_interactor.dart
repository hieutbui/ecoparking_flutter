import 'package:dartz/dartz.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/search_parking/search_parking_repository.dart';
import 'package:ecoparking_flutter/domain/state/search_parking/search_parking_state.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_by.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_order.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:geobase/geobase.dart';

class SearchParkingInteractor with InteractorLoggy {
  final SearchParkingRepository _searchParkingRepository =
      getIt.get<SearchParkingRepository>();

  Stream<Either<Failure, Success>> execute({
    String? searchQuery,
    Point? userLocation,
    double? maxDistance,
    ParkingSortBy? sortBy,
    ParkingSortOrder? sortOrder,
  }) async* {
    try {
      yield const Right(SearchParkingLoading());

      final searchResult = await _searchParkingRepository.searchParking(
        searchQuery: searchQuery,
        userLocation: userLocation,
        maxDistance: maxDistance,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

      if (searchResult != null && searchResult.isNotEmpty) {
        loggy.info('execute(): search parking success');
        final parkings = searchResult.map((e) => Parking.fromJson(e)).toList();

        yield Right(SearchParkingSuccess(parkingList: parkings));
      } else {
        loggy.error('execute(): search parking is null or empty');
        yield const Right(SearchParkingIsEmpty());
      }
    } catch (e) {
      loggy.error('execute(): search parking failure: $e');
      yield Left(SearchParkingFailure(exception: e));
    }
  }
}
