import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static const compileTimeEnv = {
    'MAPBOX_URL_TEMPLATE': String.fromEnvironment('MAPBOX_URL_TEMPLATE'),
    'MAPBOX_ACCESS_TOKEN': String.fromEnvironment('MAPBOX_ACCESS_TOKEN'),
  };

  static const String envFileName = '.env';

  static final String mapURLTemplate = _loadEnv('MAPBOX_URL_TEMPLATE');
  static final String mapAccessToken = _loadEnv('MAPBOX_ACCESS_TOKEN');

  static String _loadEnv(name) => dotenv.get(name);
}
