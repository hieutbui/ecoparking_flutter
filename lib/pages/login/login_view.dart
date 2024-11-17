import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/login/login.dart';
import 'package:ecoparking_flutter/pages/login/login_view_styles.dart';
import 'package:ecoparking_flutter/pages/login/widgets/social_button_no_text.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/text_input_row/text_input_row.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;

  const LoginView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.login.getTitle(),
      onBackButtonPressed: controller.onBackButtonPressed,
      body: Padding(
        padding: LoginViewStyles.padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    TextInputRow(
                      controller: controller.emailController,
                      hintText: 'Email',
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      isShowObscure: false,
                      onChanged: controller.onEmailChanged,
                    ),
                    const SizedBox(height: LoginViewStyles.textInputSpacing),
                    TextInputRow(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      textInputAction: TextInputAction.done,
                      prefixIcon: Icons.lock_rounded,
                      keyboardType: TextInputType.visiblePassword,
                      isShowObscure: true,
                      onChanged: controller.onPasswordChanged,
                    ),
                    const SizedBox(height: LoginViewStyles.textInputSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ValueListenableBuilder(
                          valueListenable: controller.isRememberMe,
                          builder: (context, isRememberMe, child) {
                            return GFCheckbox(
                              value: isRememberMe,
                              onChanged: controller.onRememberMeChanged,
                              type: GFCheckboxType.basic,
                              size: GFSize.SMALL,
                              activeBgColor:
                                  Theme.of(context).colorScheme.primary,
                              customBgColor:
                                  Theme.of(context).colorScheme.primary,
                              activeBorderColor:
                                  Theme.of(context).colorScheme.primary,
                              inactiveBorderColor:
                                  Theme.of(context).colorScheme.primary,
                            );
                          },
                        ),
                        const SizedBox(
                          width: LoginViewStyles.inputBottomSpacing,
                        ),
                        Text(
                          'Remember me',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: LoginViewStyles.rememberMeBottomSpacing,
                    ),
                    ActionButton(
                      type: ActionButtonType.positive,
                      label: 'Sign in',
                      onPressed: controller.onSignInPressed,
                    ),
                    const SizedBox(
                      height: LoginViewStyles.signInButtonBottomSpacing,
                    ),
                    // TextButton(
                    //   onPressed: controller.onForgotPasswordPressed,
                    //   child: Text(
                    //     'Forgot the password?',
                    //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    //           color: Theme.of(context).colorScheme.primary,
                    //         ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: LoginViewStyles.forgotPasswordBottomSpacing,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            thickness: LoginViewStyles.dividerThickness,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Padding(
                          padding: LoginViewStyles.dividerTextPadding,
                          child: Text(
                            'or continue with',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: const Color(0xFFA9A9A9),
                                ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: LoginViewStyles.dividerThickness,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: LoginViewStyles.dividerBottomSpacing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialButtonNoText(
                          icon: ImagePaths.icLoginGG,
                          onPressed: controller.onLoginWithGooglePressed,
                        ),
                        const SizedBox(
                          width: LoginViewStyles.socialButtonSpacing,
                        ),
                        SocialButtonNoText(
                          icon: ImagePaths.icLoginFB,
                          onPressed: controller.onLoginWithFacebookPressed,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: LoginViewStyles.registerAreaPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: LoginViewStyles.questionTextStyle,
                  ),
                  const SizedBox(
                    width: LoginViewStyles.signUpAreaSpacing,
                  ),
                  TextButton(
                    onPressed: controller.onSignUpPressed,
                    child: Text(
                      'Sign up',
                      style: LoginViewStyles.signUpTextStyle(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
