import 'package:ecoparking_flutter/data/datasource/profile/profile_datasource.dart';
import 'package:ecoparking_flutter/data/tables/profile_table.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<Map<String, dynamic>> updateProfile(Profile profile) async {
    const table = ProfileTable();

    return SupabaseUtils()
        .client
        .from(table.tableName)
        .update(profile.toJson())
        .eq(table.id, profile.id)
        .select()
        .single();
  }
}
