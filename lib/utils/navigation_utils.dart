import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationUtils {
  static void navigateTo({
    required BuildContext context,
    required String path,
    Object? params,
  }) {
    GoRouter.of(context).go(path, extra: params);
  }
}
