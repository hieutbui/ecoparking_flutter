import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUtils {
  final client = Supabase.instance.client;
  final auth = Supabase.instance.client.auth;
}
