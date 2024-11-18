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
    return AppScaffold(
      title: AppPaths.profile.getTitle(profileType: ProfileType.hasAccount),
      showBackButton: false,
      body: ValueListenableBuilder(
        valueListenable: controller.profileNotifier,
        builder: (context, profileState, child) {
          if (profileState is GetProfileInitial) {
            return ProfileNoAccountView(controller: controller);
          }

          if (profileState is GetProfileSuccess) {
            final profile = profileState.profile;
            final avatar = profile.avatar;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: avatar != null
                        ? GFAvatar(
                            backgroundImage: NetworkImage(avatar),
                            shape: GFAvatarShape.standard,
                            size: 132.0,
                          )
                        : SvgPicture.asset(
                            ImagePaths.icPerson,
                            width: 95.0,
                            height: 100.0,
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
            );
          }

          return child!;
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}
