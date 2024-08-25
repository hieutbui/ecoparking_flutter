import 'dart:typed_data';
import 'package:ecoparking_flutter/config/themes.dart';
import 'package:ecoparking_flutter/pages/resource/image_paths.dart';
import 'package:ecoparking_flutter/utils/bottom_sheet_utils.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/avatar_button/avatar_button.dart';
import 'package:ecoparking_flutter/widgets/date_input_row/date_input_row.dart';
import 'package:ecoparking_flutter/widgets/info_rectangle/info_rectangle.dart';
import 'package:ecoparking_flutter/widgets/phone_input_row/phone_input_row.dart';
import 'package:ecoparking_flutter/widgets/search_bar/search_bar.dart';
import 'package:ecoparking_flutter/widgets/selection_card/selection_card.dart';
import 'package:ecoparking_flutter/widgets/text_input_row/text_input_row.dart';
import 'package:ecoparking_flutter/widgets/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phone_form_field/phone_form_field.dart';

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
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          theme: EcoParkingThemes.buildTheme(context),
          home: const TestPage(),
        );
      },
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                subtitleColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              const SizedBox(height: 22),
              SelectionCard(
                title: 'Google Pay',
                trailingSVG: ImagePaths.imgGoogle,
                isSelected: false,
                isShowSelectCircle: true,
                titleColor: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 16),
              const Text('Search Bar'),
              SearchAnchor(
                builder: (context, controller) {
                  return AppSearchBar(
                    controller: controller,
                    onChanged: (String value) {
                      debugPrint(value);
                    },
                    onTap: () {
                      controller.openView();
                    },
                    isShowFilter: true,
                    onFilterPressed: () {
                      debugPrint('Filter pressed');
                    },
                  );
                },
                suggestionsBuilder: (context, controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'Item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        controller.closeView(item);
                      },
                    );
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Bottom sheet'),
              ActionButton(
                type: ActionButtonType.positive,
                label: 'Show Bottom Sheet',
                width: 175,
                onPressed: () => BottomSheetUtils.show(
                  context: context,
                  isDismissible: true,
                  isScrollControlled: true,
                  showDragHandle: true,
                  builder: (context) {
                    return Container(
                      color: Colors.amber,
                      child: Center(
                        child: ActionButton(
                          type: ActionButtonType.positive,
                          label: 'Close',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('Dialog'),
              ActionButton(
                type: ActionButtonType.positive,
                label: 'Show Dialog',
                width: 175,
                onPressed: () => DialogUtils.show(
                  context: context,
                  actions: (context) {
                    return <Widget>[
                      ActionButton(
                        type: ActionButtonType.negative,
                        label: 'Close',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ActionButton(
                        type: ActionButtonType.positive,
                        label: 'OK',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ];
                  },
                  image: ImagePaths.icDialogSuccessful,
                  title: 'Dialog Title!',
                  description: 'Dialog Description',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Avatar Button'),
              AvatarButton(
                onImageSelected: (Uint8List? image) {
                  debugPrint('Image selected: $image');
                },
              ),
              const SizedBox(height: 16),
              const Text('Text Input Row'),
              TextInputRow(
                controller: TextEditingController(),
                hintText: 'hint text',
                textInputAction: TextInputAction.done,
                isShowObscure: true,
                prefixIcon: Icons.lock_rounded,
                onChanged: (String value) {
                  debugPrint(value);
                },
              ),
              const SizedBox(height: 16),
              const Text('Phone Input Row'),
              PhoneInputRow(
                onChanged: (PhoneNumber? phoneNumber) {
                  debugPrint(phoneNumber.toString());
                },
              ),
              const SizedBox(height: 16),
              const Text('Date Input Row'),
              DateInputRow(
                onDateSelected: (DateTime? dateTime) {
                  debugPrint(dateTime.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
