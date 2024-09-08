import 'package:location/location.dart';

abstract class CurrentLocationDataSource {
  Future<LocationData?> fetchCurrentLocation();
}
