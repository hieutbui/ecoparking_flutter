import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/register_service.dart';
import 'package:ecoparking_flutter/domain/state/register/register_state.dart';
import 'package:ecoparking_flutter/domain/usecase/register/register_interactor.dart';
import 'package:ecoparking_flutter/pages/register/register_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterController createState() => RegisterController();
}

class RegisterController extends State<RegisterPage> with ControllerLoggy {
  final RegisterInteractor _registerInteractor =
      getIt.get<RegisterInteractor>();
  final RegisterService _registerService = getIt.get<RegisterService>();

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
    NavigationUtils.replaceTo(
      context: context,
      path: AppPaths.login,
    );
  }

  void loginPressed() {
    loggy.info('loginPressed()');
    NavigationUtils.replaceTo(
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
    } else {
      loggy.error('onSignUpPressed(): Email or password is empty');
    }
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
  }

  void _handleRegisterSuccess(Success success) {
    loggy.info('_handleRegisterSuccess(): $success');
    if (success is RegisterSuccess) {
      registerStateNotifier.value = success;
      final user = success.authResponse.user;
      if (user != null) {
        _registerService.setUser(user);
        NavigationUtils.navigateTo(
          context: context,
          path: AppPaths.createProfile,
        );
      }
    } else {
      registerStateNotifier.value = const RegisterEmptyAuth();
    }
  }

  void onLoginWithGooglePressed() {
    loggy.info('onLoginWithGooglePressed()');
  }

  void onLoginWithFacebookPressed() {
    loggy.info('onLoginWithFacebookPressed()');
  }

  @override
  Widget build(BuildContext context) => RegisterView(controller: this);
}
