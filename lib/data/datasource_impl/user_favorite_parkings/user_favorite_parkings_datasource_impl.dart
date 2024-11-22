import 'package:ecoparking_flutter/data/datasource/user_favorite_parkings/user_favorite_parkings_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/tables/parking_table.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';

class UserFavoriteParkingsDatasourceImpl
    implements UserFavoriteParkingsDatasource {
  @override
  Future<List<Map<String, dynamic>>?> fetchFavoriteParkings(
    List<String> favoriteParkings,
  ) async {
    const table = ParkingTable();

    return SupabaseUtils()
        .client
        .from(table.tableName)
        .select('${table.image}, ${table.name}, ${table.address}')
        .inFilter(
          table.id,
          favoriteParkings,
        );
  }
}
