import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogUtils {
  static void show({
    required BuildContext context,
    required List<Widget> Function(BuildContext) actions,
    bool isDismissible = false,
    String? image,
    String? title,
    String? description,
    double? imageWidth,
    double? imageHeight,
    double? maxHeight,
    double? maxWidth,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => _builder(
        context: context,
        actions: actions,
        image: image,
        title: title,
        description: description,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
      ),
    );
  }
}

Widget _builder({
  required BuildContext context,
  required List<Widget> Function(BuildContext) actions,
  String? image,
  String? title,
  String? description,
  double? imageWidth,
  double? imageHeight,
  double? maxHeight,
  double? maxWidth,
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
            if (image != null)
              SvgPicture.asset(
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
