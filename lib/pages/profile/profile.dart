import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/state/profile/get_profile_state.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/get_profile_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/sign_out/sign_out_interactor.dart';
import 'package:ecoparking_flutter/pages/profile/model/setting_button_arguments.dart';
import 'package:ecoparking_flutter/pages/profile/profile_view.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<ProfilePage> with ControllerLoggy {
  final AccountService _accountService = getIt.get<AccountService>();

  final SignOutInteractor _signOutInteractor = getIt.get<SignOutInteractor>();
  final GetProfileInteractor _getProfileInteractor =
      getIt.get<GetProfileInteractor>();

  final ValueNotifier<GetProfileState> profileNotifier =
      ValueNotifier<GetProfileState>(const GetProfileInitial());

  List<SettingButtonArguments> settingOptions = [];

  User? get user => _accountService.user;

  StreamSubscription? _signOutSubscription;
  StreamSubscription? _getProfileSubscription;

  @override
  void initState() {
    super.initState();
    _initializeSettingOptions();
    _onGetProfile();
  }

  @override
  void dispose() {
    _signOutSubscription?.cancel();
    _getProfileSubscription?.cancel();
    profileNotifier.dispose();
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

  void _onGetProfile() {
    final userId = user?.id;

    if (userId == null) {
      return;
    }

    _getProfileSubscription = _getProfileInteractor.execute(userId).listen(
          (result) => result.fold(
            _handleGetProfileFailure,
            _handleGetProfileSuccess,
          ),
        );
  }

  void _handleGetProfileFailure(Failure failure) {
    loggy.error('handleGetProfileFailure(): $failure');

    if (failure is GetProfileFailure) {
      loggy.error(
        'handleGetProfileFailure():: GetProfileFailure: ${failure.exception}',
      );
      profileNotifier.value = failure;
    } else {
      loggy.error('handleGetProfileFailure():: Unknown failure: $failure');
      profileNotifier.value = const GetProfileEmptyProfile();
    }

    _showGetProfileErrorDialog();
  }

  void _showGetProfileErrorDialog() {
    DialogUtils.show(
      context: context,
      title: 'Something went wrong',
      description: 'Cannot get your profile data. Please login again!',
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'Go to login',
            onPressed: () {
              NavigationUtils.replaceTo(
                context: context,
                path: AppPaths.login,
              );
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void _handleGetProfileSuccess(Success success) {
    loggy.info('handleGetProfileSuccess(): $success');

    if (success is GetProfileSuccess) {
      loggy.info('handleGetProfileSuccess(): ${success.profile}');
      profileNotifier.value = success;
      _accountService.setProfile(success.profile);
    }
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
  Widget build(BuildContext context) => ProfilePageView(controller: this);
}
