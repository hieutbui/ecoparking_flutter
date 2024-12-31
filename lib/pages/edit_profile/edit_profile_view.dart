import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/domain/state/profile/update_profile_state.dart';
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
      onBackButtonPressed: controller.onBackButtonPressed,
      body: ValueListenableBuilder(
        valueListenable: controller.updateProfileNotifier,
        builder: (context, updateProfileState, child) {
          if (updateProfileState is UpdateProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (updateProfileState is UpdateProfileInitial) {
            return Padding(
              padding: EditProfileViewStyles.padding,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: AvatarButton(
                        userAvatar: controller.avatar,
                        onImageSelected: controller.onImageSelected,
                      ),
                    ),
                    const SizedBox(
                      height: EditProfileViewStyles.inputRowSpacing,
                    ),
                    TextInputRow(
                      controller: controller.nameController,
                      hintText: 'Tên',
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
                      hintText: 'Biệt danh',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      isShowObscure: false,
                      onChanged: controller.onNickNameChanged,
                    ),
                    const SizedBox(
                      height: EditProfileViewStyles.inputRowSpacing,
                    ),
                    TextInputRow(
                      controller: controller.emailController,
                      hintText: 'Email',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      isShowObscure: false,
                      onChanged: controller.onEmailChanged,
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
                      label: 'Cập nhật',
                      onPressed: controller.onUpdatePressed,
                    )
                  ],
                ),
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
