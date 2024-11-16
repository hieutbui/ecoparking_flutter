import 'package:ecoparking_flutter/data/datasource/sign_out/sign_out_datasource.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';

class SignOutDataSourceImpl implements SignOutDataSource {
  @override
  Future<void> signOut() async {
    return SupabaseUtils().client.auth.signOut();
  }
}
