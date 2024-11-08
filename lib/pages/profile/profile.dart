import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/model/account/account.dart';
import 'package:ecoparking_flutter/pages/profile/model/setting_button_arguments.dart';
import 'package:ecoparking_flutter/pages/profile/profile_no_account_view.dart';
import 'package:ecoparking_flutter/pages/profile/profile_view.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<ProfilePage> {
  final AccountService _accountService = getIt.get<AccountService>();

  Account? get account => _accountService.account;

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

  void onPressedContinueWithGoogle() {}

  void onPressedContinueWithFacebook() {}

  void onPressedSignInWithPassword() {
    NavigationUtils.navigateTo(context: context, path: AppPaths.login);
  }

  void onPressedSignUp() {
    NavigationUtils.navigateTo(context: context, path: AppPaths.register);
  }

  @override
  Widget build(BuildContext context) => account == null
      ? ProfileNoAccountView(controller: this)
      : ProfilePageView(controller: this);
}
