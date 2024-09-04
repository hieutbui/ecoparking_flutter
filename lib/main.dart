import 'package:ecoparking_flutter/config/app_routes.dart';
import 'package:ecoparking_flutter/config/themes.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/widgets/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetItInitializer().setUp();
  await dotenv.load(fileName: '.env');

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
          title: 'Flutter Demo',
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
