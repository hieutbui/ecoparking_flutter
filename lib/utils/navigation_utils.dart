import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationUtils {
  static void navigateTo({
    required BuildContext context,
    required AppPaths path,
    Object? params,
  }) {
    debugPrint('navigateTo(): path: ${path.navigationPath}, params: $params');
    GoRouter.of(context).go(path.navigationPath, extra: params);
  }

  static void goBack(BuildContext context) {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    } else {
      GoRouter.of(context).go(AppPaths.home.path);
    }
  }
}