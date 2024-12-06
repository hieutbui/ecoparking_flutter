import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/database_functions_name.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:geobase/geobase.dart';

class ParkingsDataSourceImpl implements ParkingDataSource {
  @override
  Future<List<dynamic>?> findNearbyParkings(
    Point userLocation,
    double searchDistance,
  ) async {
    return SupabaseUtils().client.rpc(
      DatabaseFunctionsName.findNearbyParkings.functionName,
      params: {
        'user_location': userLocation.toBytesHex(),
        'search_distance': searchDistance,
      },
    );
  }

  @override
  Future<Map<String, dynamic>?> addFavoriteParking({
    required String userId,
    required String parkingId,
  }) async {
    return SupabaseUtils().client.rpc(
      DatabaseFunctionsName.addFavoriteParking.functionName,
      params: {
        'user_id': userId,
        'parking_id': parkingId,
      },
    );
  }

  @override
  Future<Map<String, dynamic>?> removeFavoriteParking({
    required String userId,
    required String parkingId,
  }) async {
    return SupabaseUtils().client.rpc(
      DatabaseFunctionsName.removeFavoriteParking.functionName,
      params: {
        'user_id': userId,
        'parking_id': parkingId,
      },
    );
  }
}
