import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/tables/parking_table.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';

class ParkingsDataSourceImpl implements ParkingDataSource {
  @override
  Future<List<Map<String, dynamic>>?> fetchParkings() async {
    const table = ParkingTable();

    return SupabaseUtils().client.from(table.tableName).select();
  }
}
