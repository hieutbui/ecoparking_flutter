import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  final HomeController controller;

  const HomePageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Home Screen');
  }
}
