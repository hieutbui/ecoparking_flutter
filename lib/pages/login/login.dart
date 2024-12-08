import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/state/login/get_google_web_client_state.dart';
import 'package:ecoparking_flutter/domain/state/login/login_with_email_state.dart';
import 'package:ecoparking_flutter/domain/usecase/login/get_google_web_client_interactor.dart';
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
  final GetGoogleWebClientInteractor _getGoogleWebClientInteractor =
      getIt.get<GetGoogleWebClientInteractor>();

  final AccountService _accountService = getIt.get<AccountService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<LoginWithEmailState> loginWithEmailNotifier =
      ValueNotifier<LoginWithEmailState>(const LoginWithEmailInitial());
  final ValueNotifier<bool> isRememberMe = ValueNotifier<bool>(false);
  final ValueNotifier<GetGoogleWebClientState> googleWebClientNotifier =
      ValueNotifier(const GetGoogleWebClientInitial());

  StreamSubscription? _loginSubscription;
  StreamSubscription? _authStateSubscription;
  StreamSubscription? _googleWebClientSubscription;

  @override
  void initState() {
    super.initState();
    _getGoogleWebClientId();
    _authStateSubscription = SupabaseUtils().auth.onAuthStateChange.listen(
      (data) {
        final session = data.session;
        if (session != null) {
          _handleAuthSuccess();
        }
      },
      onError: (error) {
        if (error is AuthException) {
          _showAuthError(exception: error);
        } else {
          _showAuthError();
        }
      },
    );
  }

  @override
  void dispose() {
    _loginSubscription?.cancel();
    _authStateSubscription?.cancel();
    _googleWebClientSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
    isRememberMe.dispose();
    super.dispose();
  }

  void _handleAuthSuccess() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.profile,
    );
  }

  void _showAuthError({
    AuthException? exception,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(exception?.message ?? 'Unknown error'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.navigateTo(
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

    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.profile,
    );
  }

  void onForgotPasswordPressed() {}

  void onLoginWithGooglePressed() async {
    loggy.info('onLoginWithGooglePressed()');
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

  void onLoginWithFacebookPressed() async {
    loggy.info('onLoginWithFacebookPressed()');
    await signInWithFacebook();
  }

  void onSignUpPressed() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.register,
    );
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
  Widget build(BuildContext context) => LoginView(controller: this);
}
