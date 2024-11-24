import 'package:ecoparking_flutter/data/datasource/markers/current_location_datasource.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationDataSourceImpl implements CurrentLocationDataSource {
  @override
  Future<Position?> fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
