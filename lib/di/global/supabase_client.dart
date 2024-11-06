import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static final client = Supabase.instance.client;
  static final auth = client.auth;
  static final session = auth.currentSession;
}
