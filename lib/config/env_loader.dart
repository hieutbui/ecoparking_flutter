import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static const compileTimeEnvironment = {
    'MAPBOX_URL_TEMPLATE': String.fromEnvironment('MAPBOX_URL_TEMPLATE'),
  };

  static const String envFileName = '.env';

  static final String mapURLTemplate = _loadEnv('MAPBOX_URL_TEMPLATE');

  static String _loadEnv(name) => dotenv.get(name);
}
