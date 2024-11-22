import 'package:ecoparking_flutter/data/datasource/user_vehicles/user_vehicles_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/tables/vehicle_table.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';

class UserVehiclesDataSourceImpl implements UserVehiclesDataSource {
  @override
  Future<List<Map<String, dynamic>>?> fetchUserVehicles() async {
    const table = VehicleTable();

    return SupabaseUtils()
        .client
        .from(table.tableName)
        .select('${table.id}, ${table.vehicleName}, ${table.licensePlate}');
  }
}
