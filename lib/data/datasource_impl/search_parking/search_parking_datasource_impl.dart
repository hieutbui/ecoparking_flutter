import 'package:ecoparking_flutter/data/datasource/search_parking/search_parking_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/database_functions_name.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_by.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_order.dart';
import 'package:geobase/geobase.dart';

class SearchParkingDataSourceImpl implements SearchParkingDataSource {
  @override
  Future<List<dynamic>?> searchParking({
    String? searchQuery,
    Point? userLocation,
    double? maxDistance,
    ParkingSortBy? sortBy,
    ParkingSortOrder? sortOrder,
  }) {
    final stringQuery = searchQuery ?? '';
    final location = userLocation != null
        ? userLocation.toBytesHex()
        : Point(Position.create(
            x: 0,
            y: 0,
          )).toBytesHex();
    final sortByString =
        sortBy != null ? sortBy.toString() : ParkingSortBy.distance.toString();
    final sortOrderString = sortOrder != null
        ? sortOrder.toString()
        : ParkingSortOrder.ascending.toString();

    return SupabaseUtils().client.rpc(
      DatabaseFunctionsName.searchParking.functionName,
      params: {
        'search_query': stringQuery,
        'user_location': location,
        'max_distance': maxDistance,
        'sort_by': sortByString,
        'sort_order': sortOrderString,
      },
    );
  }
}
