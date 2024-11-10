import 'package:ecoparking_flutter/config/app_paths.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.createProfile,
    );
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
