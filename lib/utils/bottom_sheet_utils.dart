import 'package:ecoparking_flutter/config/app_config.dart';
import 'package:flutter/material.dart';

class BottomSheetUtils {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool showDragHandle = true,
    double? maxHeight,
    double? maxWidth,
  }) async {
    return showModalBottomSheet(
      context: context,
      showDragHandle: showDragHandle,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height * 0.5,
        maxWidth: maxWidth ?? AppConfig.appColumnWidth * 1.5,
      ),
      useRootNavigator: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      backgroundColor: Colors.white,
      builder: builder,
    );
  }
}
