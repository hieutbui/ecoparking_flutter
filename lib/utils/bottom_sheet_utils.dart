import 'package:flutter/material.dart';

class BottomSheetUtils {
  static void showBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool showDragHandle = true,
    double? maxHeight,
    double? maxWidth,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: showDragHandle,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height * 0.5,
        maxWidth: maxWidth ?? 360 * 1.5,
      ),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: builder,
    );
  }
}
