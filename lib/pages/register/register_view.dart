import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/login/widgets/social_button_no_text.dart';
import 'package:ecoparking_flutter/pages/register/register.dart';
import 'package:ecoparking_flutter/pages/register/register_view_styles.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/text_input_row/text_input_row.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  final RegisterController controller;

  const RegisterView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.register.getTitle(),
      onBackButtonPressed: controller.onBackButtonPressed,
      body: Padding(
        padding: RegisterViewStyles.padding,
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
                    const SizedBox(height: RegisterViewStyles.textInputSpacing),
                    TextInputRow(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      textInputAction: TextInputAction.done,
                      prefixIcon: Icons.lock_rounded,
                      keyboardType: TextInputType.visiblePassword,
                      isShowObscure: true,
                      onChanged: controller.onPasswordChanged,
                    ),
                    const SizedBox(
                      height: RegisterViewStyles.inputBottomSpacing,
                    ),
                    ActionButton(
                      type: ActionButtonType.positive,
                      label: 'Sign up',
                      onPressed: controller.onSignUpPressed,
                    ),
                    const SizedBox(
                      height: RegisterViewStyles.signUpButtonBottomSpacing,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            thickness: RegisterViewStyles.dividerThickness,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Padding(
                          padding: RegisterViewStyles.dividerTextPadding,
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
                            thickness: RegisterViewStyles.dividerThickness,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: RegisterViewStyles.dividerBottomSpacing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialButtonNoText(
                          icon: ImagePaths.icLoginGG,
                          onPressed: controller.onLoginWithGooglePressed,
                        ),
                        const SizedBox(
                          width: RegisterViewStyles.socialButtonSpacing,
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
              padding: RegisterViewStyles.loginAreaPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: RegisterViewStyles.questionTextStyle,
                  ),
                  const SizedBox(
                    width: RegisterViewStyles.loginAreaSpacing,
                  ),
                  TextButton(
                    onPressed: controller.loginPressed,
                    child: Text(
                      'Sign in',
                      style: RegisterViewStyles.loginTextStyle(context),
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
