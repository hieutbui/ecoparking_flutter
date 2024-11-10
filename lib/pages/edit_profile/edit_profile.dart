import 'dart:typed_data';
import 'package:ecoparking_flutter/model/account/account.dart';
import 'package:ecoparking_flutter/pages/edit_profile/edit_profile_view.dart';
import 'package:ecoparking_flutter/pages/edit_profile/model/edit_profile_purpose.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:phone_form_field/phone_form_field.dart';

class EditProfile extends StatefulWidget {
  final EditProfilePurpose purpose;

  const EditProfile({
    super.key,
    required this.purpose,
  });

  @override
  EditProfileController createState() => EditProfileController();
}

class EditProfileController extends State<EditProfile> with ControllerLoggy {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '0279579637');
  final TextEditingController dateController = TextEditingController();
  final ValueNotifier<Genders?> genderNotifier = ValueNotifier<Genders?>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onImageSelected(Uint8List? imageData) {
    loggy.info('onImageSelected(): $imageData');
  }

  void onNameChanged(String value) {
    loggy.info('onNameChanged(): $value');
  }

  void onPhoneChanged(PhoneNumber? value) {
    loggy.info('onPhoneChanged(): $value');
  }

  void onDateChanged(DateTime? value) {
    loggy.info('onDateChanged(): $value');
  }

  void onGenderChange(Genders value) {
    loggy.info('onGenderChange');
  }

  void onContinuePressed() {
    loggy.info('onContinuePressed()');
  }

  @override
  Widget build(BuildContext context) => EditProfileView(
        controller: this,
        purpose: widget.purpose,
      );
}
