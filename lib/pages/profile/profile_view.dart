import 'dart:typed_data';
import 'package:ecoparking_flutter/pages/profile/profile.dart';
import 'package:ecoparking_flutter/pages/profile/widgets/setting_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/avatar_button/avatar_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePageView extends StatelessWidget {
  final ProfileController controller;

  const ProfilePageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile',
      showBackButton: false,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: AvatarButton(
                userAvatar: '',
                onImageSelected: (Uint8List? imageData) {},
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'name',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'email',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: controller.settingOptions.length,
              itemBuilder: (context, index) {
                final setting = controller.settingOptions[index];
                return SettingButton(arguments: setting);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            )
          ],
        ),
      ),
    );
  }
}
