import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/database_functions_name.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';

class ParkingsDataSourceImpl implements ParkingDataSource {
  @override
  Future<List<dynamic>?> fetchParkings() async {
    return SupabaseUtils().client.rpc(
          DatabaseFunctionsName.getParkingWithShiftPrices.functionName,
        );
  }
}
