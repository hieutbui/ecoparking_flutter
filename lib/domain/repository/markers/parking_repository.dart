import 'package:geobase/geobase.dart';

abstract class ParkingRepository {
  Future<List<dynamic>?> findNearbyParkings(
    Point userLocation,
    double searchDistance,
  );
  Future<Map<String, dynamic>?> addFavoriteParking({
    required String userId,
    required String parkingId,
  });
  Future<Map<String, dynamic>?> removeFavoriteParking({
    required String userId,
    required String parkingId,
  });
}
