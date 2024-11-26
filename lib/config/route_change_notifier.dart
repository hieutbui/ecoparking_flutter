import 'package:flutter/material.dart';

class RouteChangeNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

final routeChangeNotifier = RouteChangeNotifier();
