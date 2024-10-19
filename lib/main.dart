import 'package:ecoparking_flutter/config/app_routes.dart';
import 'package:ecoparking_flutter/config/env_loader.dart';
import 'package:ecoparking_flutter/config/themes.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:ecoparking_flutter/widgets/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loggy/loggy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          title: 'WcoParking',
          themeMode: themeMode,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          theme: EcoParkingThemes.buildTheme(context),
        );
      },
    );
  }
}
