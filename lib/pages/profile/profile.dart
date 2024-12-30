import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/state/login/get_google_web_client_state.dart';
import 'package:ecoparking_flutter/domain/state/profile/get_profile_state.dart';
import 'package:ecoparking_flutter/domain/usecase/login/get_google_web_client_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/get_profile_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/sign_out/sign_out_interactor.dart';
import 'package:ecoparking_flutter/pages/profile/model/setting_button_arguments.dart';
import 'package:ecoparking_flutter/pages/profile/profile_view.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/facebook_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/google_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<ProfilePage>
    with ControllerLoggy, GoogleAuthMixin, FacebookAuthMixin {
  final AccountService _accountService = getIt.get<AccountService>();
  final SignOutInteractor _signOutInteractor = getIt.get<SignOutInteractor>();
  final GetProfileInteractor _getProfileInteractor =
      getIt.get<GetProfileInteractor>();
  final GetGoogleWebClientInteractor _getGoogleWebClientInteractor =
      getIt.get<GetGoogleWebClientInteractor>();

  final ValueNotifier<GetProfileState> profileNotifier =
      ValueNotifier<GetProfileState>(const GetProfileInitial());
  final ValueNotifier<GetGoogleWebClientState> googleWebClientNotifier =
      ValueNotifier(const GetGoogleWebClientInitial());

  List<SettingButtonArguments> settingOptions = [];

  User? get user => _accountService.user ?? SupabaseUtils().auth.currentUser;
  Session? get session =>
      _accountService.session ?? SupabaseUtils().auth.currentSession;

  StreamSubscription? _signOutSubscription;
  StreamSubscription? _getProfileSubscription;
  StreamSubscription? _authStateSubscription;
  StreamSubscription? _googleWebClientSubscription;

  @override
  void initState() {
    super.initState();
    _initializeSettingOptions();
    _onGetProfile();
    _getGoogleWebClientId();
    _authStateSubscription = SupabaseUtils().auth.onAuthStateChange.listen(
      (data) {
        final session = data.session;
        if (session != null) {
          _onGetProfile();
        }
      },
      onError: (error) {
        if (error is AuthException) {
          _showAuthError(error: error);
        } else {
          _showAuthError();
        }
      },
    );
  }

  @override
  void dispose() {
    _signOutSubscription?.cancel();
    _getProfileSubscription?.cancel();
    _authStateSubscription?.cancel();
    _googleWebClientSubscription?.cancel();
    profileNotifier.dispose();
    super.dispose();
  }

  void _initializeSettingOptions() {
    settingOptions = [
      SettingButtonArguments(
        title: 'Edit Profile',
        leftIcon: Icons.person_outline_rounded,
        onTap: _onEditProfile,
      ),
      // SettingButtonArguments(
      //   title: 'Notification',
      //   leftIcon: Icons.notifications_outlined,
      //   onTap: () {
      //     loggy.info('Notification');
      //     NavigationUtils.navigateTo(
      //       context: context,
      //       path: AppPaths.testPage,
      //     );
      //   },
      // ),
      SettingButtonArguments(
        title: 'Logout',
        leftIcon: Icons.logout,
        isDanger: true,
        onTap: _onSignOut,
      ),
    ];
  }

  void _showAuthError({
    AuthException? error,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error?.message ?? 'Something went wrong',
        ),
      ),
    );
  }

  void _onGetProfile() {
    final profile = _accountService.profile;
    if (profile != null) {
      profileNotifier.value = GetProfileSuccess(
        profile: profile,
      );
      return;
    }

    if (user == null) {
      return;
    }

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
            label: 'OK',
            onPressed: () {
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

  void _onEditProfile() {
    if (_accountService.profile == null) {
      DialogUtils.showRequiredLogin(context);
    }

    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.editProfile,
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
    _accountService.clear();
    profileNotifier.value = const GetProfileInitial();
  }

  void onPressedContinueWithGoogle() async {
    loggy.info('onPressedContinueWithGoogle()');
    if (PlatformInfos.isWeb) {
      await signInWithGoogleOnWeb();
    } else {
      final String? googleWebClientId = _accountService.googleWebClientId;
      if (googleWebClientId != null) {
        await nativeGoogleSign(googleWebClientId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Cannot Sign In with Google, please try another method'),
          ),
        );
      }
    }
  }

  void onPressedContinueWithFacebook() async {
    loggy.info('onPressedContinueWithFacebook()');
    await signInWithFacebook();
  }

  void onPressedSignInWithPassword() {
    NavigationUtils.navigateTo(context: context, path: AppPaths.login);
  }

  void onPressedSignUp() {
    NavigationUtils.navigateTo(context: context, path: AppPaths.register);
  }

  void _getGoogleWebClientId() {
    _googleWebClientSubscription =
        _getGoogleWebClientInteractor.execute().listen(
              (event) => event.fold(
                _handleGetGoogleWebClientFailure,
                _handleGetGoogleWebClientSuccess,
              ),
            );
  }

  void _handleGetGoogleWebClientFailure(Failure failure) {
    loggy.error('handleGetGoogleWebClientFailure(): $failure');
    if (failure is GetGoogleWebClientFailure) {
      googleWebClientNotifier.value = failure;
    } else if (failure is GetGoogleWebClientEmpty) {
      googleWebClientNotifier.value = const GetGoogleWebClientEmpty();
    }
  }

  void _handleGetGoogleWebClientSuccess(Success success) {
    loggy.info('handleGetGoogleWebClientSuccess(): $success');
    if (success is GetGoogleWebClientSuccess) {
      googleWebClientNotifier.value = success;
      _accountService.setGoogleWebClientId(success.googleWebClient);
    } else if (success is GetGoogleWebClientLoading) {
      googleWebClientNotifier.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => ProfilePageView(controller: this);
}
