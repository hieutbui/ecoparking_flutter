import 'dart:typed_data';
import 'package:ecoparking_flutter/data/datasource/profile/profile_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/buckets/bucket_name.dart';
import 'package:ecoparking_flutter/data/supabase_data/tables/profile_table.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  Future<Map<String, dynamic>> getProfile(String id) async {
    const table = ProfileTable();

    return SupabaseUtils()
        .client
        .from(table.tableName)
        .select()
        .eq(table.id, id)
        .single();
  }

  @override
  Future<String> uploadAvatarOnWeb(
    String id,
    Uint8List avatar,
    String fileExtension,
  ) async {
    final avatarPath = '/$id/avatar';

    return await SupabaseUtils()
        .client
        .storage
        .from(BucketName.avatars.toString())
        .uploadBinary(
          avatarPath,
          avatar,
          fileOptions: FileOptions(
            upsert: true,
            contentType: 'image/$fileExtension',
          ),
        );
  }

  @override
  Future<String> createAvatarSignedURL(String filePath) async {
    const expiredTime = 60 * 60 * 24 * 365 * 10; // 10 years
    final bucketName = BucketName.avatars.toString();
    final correctPath = filePath.replaceAll('$bucketName/', '');

    return await SupabaseUtils()
        .client
        .storage
        .from(bucketName)
        .createSignedUrl(
          correctPath,
          expiredTime,
        );
  }
}
