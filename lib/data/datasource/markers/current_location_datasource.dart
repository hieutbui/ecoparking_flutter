import 'package:geolocator/geolocator.dart';

abstract class CurrentLocationDataSource {
  Future<Position?> fetchCurrentLocation();
}
