import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static final mapURLTemplate = _loadEnv('MAPBOX_URL_TEMPLATE');

  static String _loadEnv(name) => dotenv.get(name);
}
