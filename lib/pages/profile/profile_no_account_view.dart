import 'package:ecoparking_flutter/config/app_paths.dart';
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
      title: AppPaths.profile.getTitle(profileType: ProfileType.noAccount),
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
                      label: 'Đăng nhập bằng Google',
                      onPressed: controller.onPressedContinueWithGoogle,
                    ),
                    const SizedBox(
                      height: ProfileNoAccountViewStyles.socialButtonsSpacing,
                    ),
                    SocialLoginButton(
                      icon: ImagePaths.icLoginFB,
                      label: 'Đăng nhập bằng Facebook',
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
                            'Hoặc',
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
                      label: 'Đăng nhập bằng email',
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
                    'Không có tài khoản?',
                    style: ProfileNoAccountViewStyles.questionTextStyle,
                  ),
                  const SizedBox(
                    width: ProfileNoAccountViewStyles.signUpAreaSpacing,
                  ),
                  TextButton(
                    onPressed: controller.onPressedSignUp,
                    child: Text(
                      'Đăng ký',
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
