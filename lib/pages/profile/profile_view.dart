import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/domain/state/profile/get_profile_state.dart';
import 'package:ecoparking_flutter/pages/profile/profile.dart';
import 'package:ecoparking_flutter/pages/profile/profile_no_account_view.dart';
import 'package:ecoparking_flutter/pages/profile/profile_view_styles.dart';
import 'package:ecoparking_flutter/pages/profile/widgets/setting_button.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';

class ProfilePageView extends StatelessWidget {
  final ProfileController controller;

  const ProfilePageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.profileNotifier,
      builder: (context, getProfileState, child) {
        if (getProfileState is GetProfileInitial ||
            getProfileState is GetProfileFailure ||
            getProfileState is GetProfileEmptyProfile) {
          return ProfileNoAccountView(controller: controller);
        }

        if (getProfileState is GetProfileSuccess) {
          final profile = getProfileState.profile;
          final avatar = profile.avatar;

          return AppScaffold(
            title:
                AppPaths.profile.getTitle(profileType: ProfileType.hasAccount),
            showBackButton: false,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: avatar != null
                        ? GFAvatar(
                            backgroundImage: NetworkImage(avatar),
                            shape: GFAvatarShape.circle,
                            size: ProfileViewStyles.userAvatarSize,
                          )
                        : Container(
                            width: ProfileViewStyles.userAvatarSize,
                            height: ProfileViewStyles.userAvatarSize,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              ImagePaths.icPerson,
                              width: ProfileViewStyles.dummyIconPersonWidth,
                              height: ProfileViewStyles.dummyIconPersonHeight,
                            ),
                          ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      profile.fullName ?? '',
                      style: ProfileViewStyles.userNameStyle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      profile.email,
                      style: ProfileViewStyles.userEmailStyle,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.settingOptions.length,
                    itemBuilder: (context, index) {
                      final setting = controller.settingOptions[index];
                      return SettingButton(arguments: setting);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: ProfileViewStyles.settingButtonsSpacing,
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return child!;
      },
      child: const SizedBox.shrink(),
    );
  }
}
