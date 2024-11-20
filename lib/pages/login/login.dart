import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/state/login/login_with_email_state.dart';
import 'package:ecoparking_flutter/domain/usecase/login/login_with_email_interactor.dart';
import 'package:ecoparking_flutter/pages/login/login_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/facebook_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/google_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginController createState() => LoginController();
}

class LoginController extends State<LoginPage>
    with ControllerLoggy, GoogleAuthMixin, FacebookAuthMixin {
  final LoginWithEmailInteractor _loginWithEmailInteractor =
      getIt.get<LoginWithEmailInteractor>();

  final AccountService _accountService = getIt.get<AccountService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<LoginWithEmailState> loginWithEmailNotifier =
      ValueNotifier<LoginWithEmailState>(const LoginWithEmailInitial());
  final ValueNotifier<bool> isRememberMe = ValueNotifier<bool>(false);

  StreamSubscription? _loginSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _loginSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
    isRememberMe.dispose();
    super.dispose();
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.replaceTo(
      context: scaffoldContext,
      path: AppPaths.profile,
    );
  }

  void onEmailChanged(String value) {
    loggy.info('onEmailChanged(): $value');
  }

  void onPasswordChanged(String value) {
    loggy.info('onPasswordChanged(): $value');
  }

  void onRememberMeChanged(bool value) {
    loggy.info('onRememberMeChanged(): $value');
    isRememberMe.value = value;
  }

  void onSignInPressed() {
    loggy.info('onSignInPressed()');
    _loginSubscription = _loginWithEmailInteractor
        .execute(
          emailController.text,
          passwordController.text,
        )
        .listen(
          (result) => result.fold(
            _handleLoginWithEmailFailure,
            _handleLoginWithEmailSuccess,
          ),
        );
  }

  void _handleLoginWithEmailFailure(Failure failure) {
    loggy.error('_handleLoginWithEmailFailure(): $failure');
    if (failure is LoginWithEmailEmptyAuth) {
      loggy.error('_handleLoginWithEmailFailure(): LoginWithEmailEmptyAuth');
      loginWithEmailNotifier.value = const LoginWithEmailEmptyAuth();
    } else if (failure is LoginWithEmailAuthFailure) {
      _handleLoginWithEmailAuthFailure(failure);
    } else if (failure is LoginWithEmailOtherFailure) {
      loggy.error('_handleLoginWithEmailFailure(): LoginWithEmailOtherFailure');
      loginWithEmailNotifier.value = failure;
    }
  }

  void _handleLoginWithEmailAuthFailure(LoginWithEmailAuthFailure failure) {
    loggy.error('_handleLoginWithEmailAuthFailure(): $failure');
    loginWithEmailNotifier.value = failure;
    final AuthException exception = failure.exception;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(exception.message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleLoginWithEmailSuccess(Success success) {
    loggy.info('_handleLoginWithEmailSuccess(): $success');
    if (success is LoginWithEmailSuccess) {
      _handleLoginWIthEmailSuccess(success);
    } else {
      loggy.error('_handleLoginWithEmailSuccess(): Unknown success');
      loginWithEmailNotifier.value = const LoginWithEmailEmptyAuth();
    }
  }

  void _handleLoginWIthEmailSuccess(LoginWithEmailSuccess success) {
    loggy.info('_handleLoginWIthEmailSuccess(): $success');
    loginWithEmailNotifier.value = success;
    _accountService.setUser(success.authResponse.user);
    _accountService.setSession(success.authResponse.session);

    NavigationUtils.replaceTo(
      context: context,
      path: AppPaths.profile,
    );
  }

  void onForgotPasswordPressed() {}

  void onLoginWithGooglePressed() async {
    loggy.info('onLoginWithGooglePressed()');
    if (PlatformInfos.isWeb) {
      await signInWithGoogleOnWeb();
    }
  }

  void onLoginWithFacebookPressed() {
    loggy.info('onLoginWithFacebookPressed()');
    if (PlatformInfos.isWeb) {
      signInWithFacebookOnWeb();
    }
  }

  void onSignUpPressed() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.register,
    );
  }

  @override
  Widget build(BuildContext context) => LoginView(controller: this);
}
