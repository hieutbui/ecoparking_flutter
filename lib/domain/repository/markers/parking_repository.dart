import 'package:geobase/geobase.dart';

abstract class ParkingRepository {
  Future<List<dynamic>?> findNearbyParkings(
    Point userLocation,
    double searchDistance,
  );
}
