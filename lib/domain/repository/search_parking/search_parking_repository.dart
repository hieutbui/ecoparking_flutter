import 'package:ecoparking_flutter/model/parking/parking_sort_by.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_order.dart';
import 'package:geobase/geobase.dart';

abstract class SearchParkingRepository {
  Future<List<dynamic>?> searchParking({
    String? searchQuery,
    Point? userLocation,
    double? maxDistance,
    ParkingSortBy? sortBy,
    ParkingSortOrder? sortOrder,
  });
}
