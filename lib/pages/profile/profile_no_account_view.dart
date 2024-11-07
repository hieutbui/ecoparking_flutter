import 'package:ecoparking_flutter/pages/profile/profile.dart';
import 'package:ecoparking_flutter/pages/profile/profile_no_account_view_styles.dart';
import 'package:ecoparking_flutter/pages/profile/widgets/social_login_button.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ProfileNoAccountView extends StatelessWidget {
  final ProfileController controller;

  const ProfileNoAccountView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Let’s you in',
      showBackButton: false,
      body: Padding(
        padding: ProfileNoAccountViewStyles.padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    SocialLoginButton(
                      icon: ImagePaths.icLoginGG,
                      label: 'Continue with Google',
                      onPressed: controller.onPressedContinueWithGoogle,
                    ),
                    const SizedBox(
                      height: ProfileNoAccountViewStyles.socialButtonsSpacing,
                    ),
                    SocialLoginButton(
                      icon: ImagePaths.icLoginFB,
                      label: 'Continue with Facebook',
                      onPressed: controller.onPressedContinueWithFacebook,
                    ),
                    const SizedBox(
                      height: ProfileNoAccountViewStyles.dividerSpacing,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            thickness:
                                ProfileNoAccountViewStyles.dividerThickness,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Padding(
                          padding:
                              ProfileNoAccountViewStyles.dividerTextPadding,
                          child: Text(
                            'Or',
                            style: ProfileNoAccountViewStyles.dividerTextStyle(
                              context,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness:
                                ProfileNoAccountViewStyles.dividerThickness,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: ProfileNoAccountViewStyles.dividerSpacing,
                    ),
                    ActionButton(
                      type: ActionButtonType.positive,
                      label: 'Sign in with password',
                      onPressed: controller.onPressedSignInWithPassword,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: ProfileNoAccountViewStyles.signUpAreaPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: ProfileNoAccountViewStyles.questionTextStyle,
                  ),
                  const SizedBox(
                    width: ProfileNoAccountViewStyles.signUpAreaSpacing,
                  ),
                  TextButton(
                    onPressed: controller.onPressedSignUp,
                    child: Text(
                      'Sign up',
                      style:
                          ProfileNoAccountViewStyles.signUpTextStyle(context),
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
