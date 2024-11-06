import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static const compileTimeEnvironment = {
    'MAPBOX_URL_TEMPLATE': String.fromEnvironment('MAPBOX_URL_TEMPLATE'),
    'SUPABASE_PROJECT_URL': String.fromEnvironment('SUPABASE_PROJECT_URL'),
    'SUPABASE_ANON_KEY': String.fromEnvironment('SUPABASE_ANON_KEY'),
  };

  static const String envFileName = '.env';

  static final String mapURLTemplate = _loadEnv('MAPBOX_URL_TEMPLATE');
  static final String supabaseProjectUrl = _loadEnv('SUPABASE_PROJECT_URL');
  static final String supabaseAnonKey = _loadEnv('SUPABASE_ANON_KEY');

  static String _loadEnv(name) => dotenv.get(name);
}
