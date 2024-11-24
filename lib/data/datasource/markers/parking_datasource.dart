import 'package:geobase/geobase.dart';

abstract class ParkingDataSource {
  Future<List<dynamic>?> findNearbyParkings(
    Point userLocation,
    double searchDistance,
  );
}
