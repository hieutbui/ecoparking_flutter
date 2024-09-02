import 'package:ecoparking_flutter/pages/saved/saved.dart';
import 'package:flutter/material.dart';

class SavedPageView extends StatelessWidget {
  final SavedController controller;

  const SavedPageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Saved Screen');
  }
}
