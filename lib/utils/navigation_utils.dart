import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/config/route_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationUtils {
  static void navigateTo({
    required BuildContext context,
    required AppPaths path,
    Object? params,
  }) {
    routeChangeNotifier.notify();
    GoRouter.of(context).go(path.navigationPath, extra: params);
  }

  static void replaceTo({
    required BuildContext context,
    required AppPaths path,
    Object? params,
  }) {
    routeChangeNotifier.notify();
    GoRouter.of(context).replace(path.navigationPath, extra: params);
  }

  static void goBack(BuildContext context) {
    routeChangeNotifier.notify();
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    } else {
      GoRouter.of(context).go(AppPaths.home.path);
    }
  }
}
