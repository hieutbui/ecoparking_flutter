import 'package:location/location.dart';

abstract class CurrentLocationRepository {
  Future<LocationData?> fetchCurrentLocation();
}
