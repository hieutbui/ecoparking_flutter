import 'package:geolocator/geolocator.dart';

abstract class CurrentLocationRepository {
  Future<Position?> fetchCurrentLocation();
}
