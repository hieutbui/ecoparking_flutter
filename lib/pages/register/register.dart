import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/register_service.dart';
import 'package:ecoparking_flutter/domain/state/register/register_state.dart';
import 'package:ecoparking_flutter/domain/usecase/register/register_interactor.dart';
import 'package:ecoparking_flutter/pages/register/register_view.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/facebook_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/google_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterController createState() => RegisterController();
}

class RegisterController extends State<RegisterPage>
    with ControllerLoggy, GoogleAuthMixin, FacebookAuthMixin {
  final RegisterInteractor _registerInteractor =
      getIt.get<RegisterInteractor>();

  final RegisterService _registerService = getIt.get<RegisterService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final registerStateNotifier = ValueNotifier<RegisterState>(
    const RegisterInitial(),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  StreamSubscription? _registerSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _registerSubscription?.cancel();
    emailController.text = '';
    passwordController.text = '';
    emailController.dispose();
    passwordController.dispose();
    registerStateNotifier.dispose();
    super.dispose();
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.login,
    );
  }

  void loginPressed() {
    loggy.info('loginPressed()');
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.login,
    );
  }

  void onEmailChanged(String value) {
    loggy.info('onEmailChanged(): $value');
  }

  void onPasswordChanged(String value) {
    loggy.info('onPasswordChanged(): $value');
  }

  void onSignUpPressed() {
    loggy.info('onSignUpPressed()');
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _registerSubscription = _registerInteractor
          .execute(
            emailController.text,
            passwordController.text,
          )
          .listen(
            (result) => result.fold(
              _handleRegisterFailure,
              _handleRegisterSuccess,
            ),
          );
    } else {}
  }

  void _handleRegisterFailure(Failure failure) {
    loggy.error('_handleRegisterFailure(): $failure');
    if (failure is RegisterAuthFailure) {
      registerStateNotifier.value = failure;
    } else if (failure is RegisterOtherFailure) {
      registerStateNotifier.value = failure;
    } else {
      registerStateNotifier.value = const RegisterEmptyAuth();
    }

    _showRegisterFailureDialog();
  }

  void _handleRegisterSuccess(Success success) {
    loggy.info('_handleRegisterSuccess(): $success');
    if (success is RegisterSuccess) {
      registerStateNotifier.value = success;
      final user = success.authResponse.user;
      if (user != null) {
        _processRegistered(user);
      }
    } else {
      registerStateNotifier.value = const RegisterEmptyAuth();
    }
  }

  void _showRegisterFailureDialog() {
    loggy.info('_showRegisterFailureDialog()');
    DialogUtils.show(
      context: context,
      svgImage: ImagePaths.imgDialogError,
      title: 'Register Failed!',
      description: 'Please try again!',
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

  void _processRegistered(User user) {
    loggy.info('_processRegistered()');
    if (user.emailConfirmedAt != null) {
      DialogUtils.show(
        context: context,
        svgImage: ImagePaths.imgDialogSuccessful,
        title: 'Register!',
        description: 'Your email has been verified!',
        actions: (context) {
          return <Widget>[
            ActionButton(
              type: ActionButtonType.positive,
              label: 'Go to Login',
              onPressed: () {
                NavigationUtils.navigateTo(
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

    _registerService.setUser(user);
    _showRegisterSuccessDialog();
  }

  void _showRegisterSuccessDialog() {
    loggy.info('showRegisterSuccessDialog()');

    DialogUtils.show(
      context: context,
      svgImage: ImagePaths.imgDialogSuccessful,
      title: 'Register Success!',
      description: 'OTP has been sent to your email. Please check your email!',
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'Go to Verify OTP',
            onPressed: () {
              NavigationUtils.navigateTo(
                context: context,
                path: AppPaths.registerVerify,
              );
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

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

  void onLoginWithFacebookPressed() {
    loggy.info('onLoginWithFacebookPressed()');
    if (PlatformInfos.isWeb) {
      signInWithFacebookOnWeb();
    }
  }

  @override
  Widget build(BuildContext context) => RegisterView(controller: this);
}
