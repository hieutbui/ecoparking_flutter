import 'package:ecoparking_flutter/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class ProfilePageView extends StatelessWidget {
  final ProfileController controller;

  const ProfilePageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Profile Screen');
  }
}
