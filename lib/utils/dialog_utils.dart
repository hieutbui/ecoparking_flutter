import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogUtils {
  static final GlobalKey<ScaffoldState> dialogScaffoldKey =
      GlobalKey<ScaffoldState>();

  static Future<void> show({
    required BuildContext context,
    required List<Widget> Function(BuildContext) actions,
    bool isDismissible = false,
    String? svgImage,
    String? image,
    String? title,
    String? description,
    double? imageWidth,
    double? imageHeight,
    double? maxHeight,
    double? maxWidth,
    bool useRootNavigator = true,
    Widget? customDescription,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) => _builder(
        context: context,
        actions: actions,
        svgImage: svgImage,
        image: image,
        title: title,
        description: description,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        customDescription: customDescription,
      ),
    );
  }

  static Future<void> showRequiredLogin(BuildContext context) {
    return show(
      context: context,
      title: 'Login Required',
      description: 'You need to login to continue',
      svgImage: ImagePaths.imgDialogError,
      actions: (dialogContext) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'OK',
            onPressed: () {
              DialogUtils.hide(dialogContext);
            },
          )
        ];
      },
    );
  }

  static Future<void> showLoading({
    required BuildContext context,
    bool isDismissible = false,
    bool useRootNavigator = true,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

Widget _builder({
  required BuildContext context,
  required List<Widget> Function(BuildContext) actions,
  String? svgImage,
  String? image,
  String? title,
  String? description,
  double? imageWidth,
  double? imageHeight,
  double? maxHeight,
  double? maxWidth,
  Widget? customDescription,
}) {
  return Dialog(
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (svgImage != null)
              SvgPicture.asset(
                svgImage,
                height: imageHeight ?? 155,
                width: imageWidth ?? 179,
              ),
            if (image != null)
              Image.asset(
                image,
                height: imageHeight ?? 155,
                width: imageWidth ?? 179,
              ),
            Text(
              title ?? 'Dialog Title',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            if (customDescription != null) ...[
              customDescription,
            ] else
              Text(
                description ?? 'Dialog Description',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            const SizedBox(height: 22),
            Column(
              children: actions(context),
            )
          ],
        ),
      ),
    ),
  );
}
