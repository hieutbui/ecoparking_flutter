import 'package:ecoparking_flutter/data/supabase_data/tables/supabase_table.dart';

class VehicleTable implements SupabaseTable {
  const VehicleTable();

  @override
  String get tableName => 'vehicle';

  String get id => 'id';
  String get vehicleName => 'vehicle_name';
  String get licensePlate => 'license_plate';
}
