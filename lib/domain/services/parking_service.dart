import 'package:ecoparking_flutter/model/parking/parking.dart';

class ParkingService {
  Parking? _selectedParking;

  Parking? get selectedParking => _selectedParking;

  void selectParking(Parking parking) {
    _selectedParking = parking;
  }

  void clearSelectedParking() {
    _selectedParking = null;
  }
}
