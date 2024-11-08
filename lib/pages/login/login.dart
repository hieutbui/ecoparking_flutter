import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/login/login_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginController createState() => LoginController();
}

class LoginController extends State<LoginPage> with ControllerLoggy {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> isRememberMe = ValueNotifier<bool>(false);

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

  void onSignInPressed() {}

  void onForgotPasswordPressed() {}

  void onLoginWithGooglePressed() {}

  void onLoginWithFacebookPressed() {}

  void onSignUpPressed() {}

  @override
  Widget build(BuildContext context) => LoginView(controller: this);
}
