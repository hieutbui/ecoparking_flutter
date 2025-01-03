import 'package:ecoparking_flutter/config/app_config.dart';
import 'package:ecoparking_flutter/config/app_routes.dart';
import 'package:ecoparking_flutter/config/env_loader.dart';
import 'package:ecoparking_flutter/config/themes.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/global/hive_initializer.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:ecoparking_flutter/widgets/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loggy/loggy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveInitializer.init();

  GetItInitializer().setUp();

  if (PlatformInfos.isRelease) {
    await dotenv.load(mergeWith: EnvLoader.compileTimeEnvironment);
  } else {
    await dotenv.load(fileName: EnvLoader.envFileName);
  }

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  await Supabase.initialize(
    url: EnvLoader.supabaseProjectUrl,
    anonKey: EnvLoader.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  Stripe.publishableKey = EnvLoader.stripePublishableKey;
  Stripe.instance.applySettings();

  usePathUrlStrategy();

  runApp(const EcoParkingApp());
}

class EcoParkingApp extends StatelessWidget {
  const EcoParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) {
        return MaterialApp.router(
          routerConfig: AppRoutes.router,
          title: AppConfig.appTitle,
          themeMode: themeMode,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', 'VN'),
          ],
          locale: const Locale('vi', 'VN'),
          theme: EcoParkingThemes.buildTheme(context),
          builder: (context, child) {
            return Scaffold(
              key: DialogUtils.dialogScaffoldKey,
              body: child,
            );
          },
        );
      },
    );
  }
}
