import 'dart:async';
import 'dart:typed_data';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/state/profile/update_profile_state.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/update_profile_interactor.dart';
import 'package:ecoparking_flutter/model/account/account.dart';
import 'package:ecoparking_flutter/pages/edit_profile/edit_profile_view.dart';
import 'package:ecoparking_flutter/pages/edit_profile/model/avatar_data.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileController createState() => EditProfileController();
}

class EditProfileController extends State<EditProfile> with ControllerLoggy {
  final AccountService _accountService = getIt.get<AccountService>();
  final UpdateProfileInteractor _updateProfileInteractor =
      getIt.get<UpdateProfileInteractor>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final ValueNotifier<UpdateProfileState> updateProfileNotifier =
      ValueNotifier<UpdateProfileState>(const UpdateProfileInitial());

  final ValueNotifier<Genders?> genderNotifier = ValueNotifier<Genders?>(null);
  final ValueNotifier<DateTime?> dateNotifier = ValueNotifier<DateTime?>(null);
  final ValueNotifier<AvatarData?> imageNotifier =
      ValueNotifier<AvatarData?>(null);

  StreamSubscription? _updateProfileSubscription;
  String get avatar => _accountService.profile?.avatar ?? '';

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    _disposeControllers();
    _disposeNotifiers();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _updateProfileSubscription?.cancel();
  }

  void _disposeControllers() {
    emailController.dispose();
    nameController.dispose();
    nickNameController.dispose();
    phoneController.dispose();
  }

  void _disposeNotifiers() {
    genderNotifier.dispose();
    dateNotifier.dispose();
    imageNotifier.dispose();
  }

  void _initializeProfile() {
    final profile = _accountService.profile;

    if (profile != null) {
      nameController.text = profile.fullName ?? '';
      nickNameController.text = profile.displayName ?? '';
      phoneController.text = profile.phone ?? '';
      emailController.text = profile.email;
      genderNotifier.value = profile.gender;
      dateNotifier.value = profile.dob;
    }
  }

  void onImageSelected(Uint8List? imageData, String? fileExtension) {
    loggy.info('onImageSelected(): $imageData $fileExtension');
    if (imageData != null && fileExtension != null) {
      imageNotifier.value = AvatarData(
        bytes: imageData,
        fileExtension: fileExtension,
      );
    }
  }

  void onNameChanged(String value) {
    loggy.info('onNameChanged(): $value');
  }

  void onNickNameChanged(String value) {
    loggy.info('onNickNameChanged(): $value');
  }

  void onEmailChanged(String value) {
    loggy.info('onEmailChanged(): $value');
  }

  void onPhoneChanged(PhoneNumber? value) {
    loggy.info('onPhoneChanged(): $value');
    phoneController.text = value?.international ?? '';
  }

  void onDateChanged(DateTime? value) {
    loggy.info('onDateChanged(): $value');
    dateNotifier.value = value;
  }

  void onGenderChange(Genders value) {
    loggy.info('onGenderChange');
    genderNotifier.value = value;
  }

  void onUpdatePressed() {
    loggy.info('onUpdatePressed()');

    final currentProfile = _accountService.profile;

    if (currentProfile == null || currentProfile.id.isEmpty) {
      return;
    }

    final profileNewData = currentProfile.copyWith(
      email: emailController.text,
      fullName: nameController.text,
      displayName: nickNameController.text,
      phone: phoneController.text,
      dob: dateNotifier.value,
      gender: genderNotifier.value,
    );

    final newAvatar = imageNotifier.value;

    _updateProfileSubscription = _updateProfileInteractor
        .execute(
          profileNewData,
          avatar: newAvatar,
        )
        .listen(
          (result) => result.fold(
            _handleUpdateProfileFailure,
            _handleUpdateProfileSuccess,
          ),
        );
  }

  void _handleUpdateProfileFailure(Failure failure) {
    loggy.error('onUpdatePressed(): update profile failure: $failure');

    if (failure is UpdateProfileStorageFailure) {
      loggy.error(
        'onUpdatePressed():: UpdateProfileFailure: ${failure.exception}',
      );
      updateProfileNotifier.value = failure;
    } else if (failure is UpdateProfileFailure) {
      loggy.error(
        'onUpdatePressed():: UpdateProfileFailure: ${failure.exception}',
      );
      updateProfileNotifier.value = failure;
    } else {
      loggy.error('onUpdatePressed():: Unknown failure: $failure');
      updateProfileNotifier.value = const UpdateProfileUnknownFailure();
    }

    _showUpdateProfileErrorDialog();
  }

  void _handleUpdateProfileSuccess(Success success) {
    loggy.info('onUpdatePressed(): update profile success: $success');
    if (success is UpdateProfileSuccess) {
      loggy.info('onUpdatePressed(): ${success.profile}');
      _accountService.setProfile(success.profile);
      updateProfileNotifier.value = success;

      DialogUtils.show(
        context: context,
        title: 'Success',
        description: 'Your profile has been updated successfully!',
        svgImage: ImagePaths.imgDialogSuccessful,
        actions: (context) {
          return <Widget>[
            ActionButton(
              type: ActionButtonType.positive,
              label: 'OK',
              onPressed: () {
                NavigationUtils.replaceTo(
                  context: context,
                  path: AppPaths.profile,
                );
                DialogUtils.hide(context);
              },
            ),
          ];
        },
      );
    }
  }

  void _showUpdateProfileErrorDialog() {
    DialogUtils.show(
      context: context,
      title: 'Something went wrong',
      description: 'Cannot update your profile data. Please try again later!',
      svgImage: ImagePaths.imgDialogError,
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'OK',
            onPressed: () {
              NavigationUtils.replaceTo(
                context: context,
                path: AppPaths.profile,
              );
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.replaceTo(
      context: scaffoldContext,
      path: AppPaths.profile,
    );
  }

  @override
  Widget build(BuildContext context) => EditProfileView(controller: this);
}
