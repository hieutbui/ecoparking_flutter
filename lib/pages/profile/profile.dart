import 'package:ecoparking_flutter/pages/profile/model/setting_button_arguments.dart';
import 'package:ecoparking_flutter/pages/profile/profile_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<ProfilePage> {
  final List<SettingButtonArguments> settingOptions = [
    SettingButtonArguments(
      title: 'Edit Profile',
      leftIcon: Icons.person_outline_rounded,
      onTap: () {},
    ),
    SettingButtonArguments(
      title: 'Notification',
      leftIcon: Icons.notifications_outlined,
      onTap: () {},
    ),
    SettingButtonArguments(
      title: 'Logout',
      leftIcon: Icons.logout,
      isDanger: true,
      onTap: () {},
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ProfilePageView(controller: this);
}
