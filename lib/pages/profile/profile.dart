import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/usecase/sign_out/sign_out_interactor.dart';
import 'package:ecoparking_flutter/pages/profile/model/setting_button_arguments.dart';
import 'package:ecoparking_flutter/pages/profile/profile_no_account_view.dart';
import 'package:ecoparking_flutter/pages/profile/profile_view.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<ProfilePage> {
  final AccountService _accountService = getIt.get<AccountService>();

  final SignOutInteractor _signOutInteractor = getIt.get<SignOutInteractor>();

  List<SettingButtonArguments> settingOptions = [];

  User? get user => _accountService.user;

  StreamSubscription? _signOutSubscription;

  @override
  void initState() {
    super.initState();
    _initializeSettingOptions();
  }

  @override
  void dispose() {
    _signOutSubscription?.cancel();
    super.dispose();
  }

  void _initializeSettingOptions() {
    settingOptions = [
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
        onTap: _onSignOut,
      ),
    ];
  }

  void _onSignOut() {
    _signOutSubscription = _signOutInteractor.execute().listen(
          (result) => result.fold(
            _handleSignOutFailure,
            _handleSignOutSuccess,
          ),
        );
  }

  void _handleSignOutFailure(Failure failure) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign out failed'),
      ),
    );
  }

  void _handleSignOutSuccess(Success success) {
    setState(() {
      _accountService.clear();
    });
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
  Widget build(BuildContext context) => user == null
      ? ProfileNoAccountView(controller: this)
      : ProfilePageView(controller: this);
}
