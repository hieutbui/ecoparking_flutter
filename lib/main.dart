import 'package:ecoparking_flutter/config/themes.dart';
import 'package:ecoparking_flutter/pages/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/info_rectangle/info_rectangle.dart';
import 'package:ecoparking_flutter/widgets/selection_card/selection_card.dart';
import 'package:ecoparking_flutter/widgets/theme_builder.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeMode,
          theme: EcoParkingThemes.buildTheme(context),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Flutter Demo'),
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const Text('Action Button'),
                  ActionButton(
                    type: ActionButtonType.positive,
                    label: 'Details',
                    isShowArrow: true,
                    width: 175,
                    arrowSize: 16,
                    onPressed: () {},
                  ),
                  ActionButton(
                    type: ActionButtonType.negative,
                    label: 'Cancel',
                    isShowArrow: true,
                    width: 175,
                    onPressed: () {},
                  ),
                  ActionButton(
                    type: ActionButtonType.hollow,
                    label: 'Submit',
                    isShowArrow: false,
                    width: 175,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  const Text('Info Rectangle'),
                  const InfoRectangle(
                    type: InfoRectangleType.filled,
                    label: 'Filled Rectangle',
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    icon: Icons.location_on,
                  ),
                  const InfoRectangle(
                    type: InfoRectangleType.hollow,
                    label: 'Hollow Rectangle',
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    icon: Icons.punch_clock_rounded,
                  ),
                  const SizedBox(height: 16),
                  const Text('Selection Card'),
                  SelectionCard(
                    title: 'Toyota  Land Cruiser',
                    subtitle: 'AFD 6397',
                    trailingImage: ImagePaths.imgToyotaLandCruiser,
                    isSelected: true,
                    isShowSelectCircle: true,
                    titleColor: Theme.of(context).colorScheme.onSurface,
                    subtitleColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                  const SizedBox(height: 22),
                  SelectionCard(
                    title: 'Google Pay',
                    trailingSVG: ImagePaths.imgGoogle,
                    isSelected: false,
                    isShowSelectCircle: true,
                    titleColor: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
