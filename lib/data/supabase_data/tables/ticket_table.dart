import 'package:ecoparking_flutter/data/supabase_data/tables/supabase_table.dart';

class TicketTable implements SupabaseTable {
  const TicketTable();

  @override
  String get tableName => 'ticket';

  String get id => 'id';
  String get parkingId => 'parking_id';
  String get userId => 'user_id';
  String get vehicleId => 'vehicle_id';
  String get startTime => 'start_time';
  String get endTime => 'end_time';
  String get days => 'days';
  String get hours => 'hours';
  String get total => 'total';
  String get status => 'status';
}
