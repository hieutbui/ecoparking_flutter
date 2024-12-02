import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static const compileTimeEnvironment = {
    'MAPBOX_URL_TEMPLATE': String.fromEnvironment('MAPBOX_URL_TEMPLATE'),
    'SUPABASE_PROJECT_URL': String.fromEnvironment('SUPABASE_PROJECT_URL'),
    'SUPABASE_ANON_KEY': String.fromEnvironment('SUPABASE_ANON_KEY'),
    'PULL_REQUEST_NUMBER': String.fromEnvironment('PULL_REQUEST_NUMBER'),
    'RELEASE_TAG': String.fromEnvironment('RELEASE_TAG'),
    'IS_RELEASE': String.fromEnvironment('IS_RELEASE'),
    'STRIPE_PUBLISHABLE_KEY': String.fromEnvironment('STRIPE_PUBLISHABLE_KEY'),
    'STRIPE_SECRET_KEY': String.fromEnvironment('STRIPE_SECRET_KEY'),
  };

  static const String envFileName = '.env';

  static final String mapURLTemplate = _loadEnv('MAPBOX_URL_TEMPLATE');
  static final String supabaseProjectUrl = _loadEnv('SUPABASE_PROJECT_URL');
  static final String supabaseAnonKey = _loadEnv('SUPABASE_ANON_KEY');
  static final String pullRequestNumber = _loadEnv('PULL_REQUEST_NUMBER');
  static final String releaseTag = _loadEnv('RELEASE_TAG');
  static final String stripePublishableKey = _loadEnv('STRIPE_PUBLISHABLE_KEY');
  static final String stripeSecretKey = _loadEnv('STRIPE_SECRET_KEY');
  static final bool isRelease = _loadEnvBool('IS_RELEASE');

  static String _loadEnv(name) => dotenv.get(name);
  static bool _loadEnvBool(name) {
    final value = _loadEnv(name).toLowerCase();
    return value == 'true';
  }
}
