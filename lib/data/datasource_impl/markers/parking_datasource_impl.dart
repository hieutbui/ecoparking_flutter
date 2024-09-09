import 'package:ecoparking_flutter/config/dummy_data.dart';
import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';

class ParkingsDataSourceImpl implements ParkingDataSource {
  @override
  Future<List<Parking>?> fetchParkings() async {
    await Future.delayed(const Duration(seconds: 2));

    //TODO: Implement fetching data from API
    return DummyData.parkings;
  }
}
