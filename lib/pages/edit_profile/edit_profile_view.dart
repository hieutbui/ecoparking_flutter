import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/edit_profile/edit_profile.dart';
import 'package:ecoparking_flutter/pages/edit_profile/edit_profile_view_styles.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/avatar_button/avatar_button.dart';
import 'package:ecoparking_flutter/widgets/date_input_row/date_input_row.dart';
import 'package:ecoparking_flutter/widgets/dropdown_gender/dropdown_gender.dart';
import 'package:ecoparking_flutter/widgets/phone_input_row/phone_input_row.dart';
import 'package:ecoparking_flutter/widgets/text_input_row/text_input_row.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  final EditProfileController controller;

  const EditProfileView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.editProfile.getTitle(),
      body: Padding(
        padding: EditProfileViewStyles.padding,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AvatarButton(
                  userAvatar: '',
                  onImageSelected: controller.onImageSelected,
                ),
              ),
              const SizedBox(
                height: EditProfileViewStyles.inputRowSpacing,
              ),
              TextInputRow(
                controller: controller.nameController,
                hintText: 'Full Name',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                isShowObscure: false,
                onChanged: controller.onNameChanged,
              ),
              const SizedBox(
                height: EditProfileViewStyles.inputRowSpacing,
              ),
              TextInputRow(
                controller: controller.nickNameController,
                hintText: 'Nick name',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                isShowObscure: false,
                onChanged: controller.onNickNameChanged,
              ),
              const SizedBox(
                height: EditProfileViewStyles.inputRowSpacing,
              ),
              PhoneInputRow(
                initialPhoneNumber: controller.phoneController.text,
                onChanged: controller.onPhoneChanged,
              ),
              const SizedBox(
                height: EditProfileViewStyles.inputRowSpacing,
              ),
              DropdownGender(
                initialGender: controller.genderNotifier.value,
                onSelectGender: controller.onGenderChange,
              ),
              const SizedBox(
                height: EditProfileViewStyles.inputRowSpacing,
              ),
              DateInputRow(
                initialDate: controller.dateNotifier.value,
                onDateSelected: controller.onDateChanged,
              ),
              const SizedBox(
                height: EditProfileViewStyles.inputRowSpacing,
              ),
              ActionButton(
                type: ActionButtonType.positive,
                label: 'Update',
                onPressed: controller.onUpdatePressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}