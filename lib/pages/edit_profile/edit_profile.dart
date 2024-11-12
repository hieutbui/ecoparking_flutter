import 'dart:async';
import 'dart:typed_data';
import 'package:ecoparking_flutter/model/account/account.dart';
import 'package:ecoparking_flutter/pages/edit_profile/edit_profile_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:phone_form_field/phone_form_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileController createState() => EditProfileController();
}

class EditProfileController extends State<EditProfile> with ControllerLoggy {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '0279579637');
  final TextEditingController dateController = TextEditingController();
  final ValueNotifier<Genders?> genderNotifier = ValueNotifier<Genders?>(null);
  final ValueNotifier<DateTime?> dateNotifier = ValueNotifier<DateTime?>(null);

  StreamSubscription? _updateProfileSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _updateProfileSubscription?.cancel();
    nameController.dispose();
    nickNameController.dispose();
    phoneController.dispose();
    dateController.dispose();
    genderNotifier.dispose();
    dateNotifier.dispose();
    super.dispose();
  }

  void onImageSelected(Uint8List? imageData) {
    loggy.info('onImageSelected(): $imageData');
  }

  void onNameChanged(String value) {
    loggy.info('onNameChanged(): $value');
  }

  void onNickNameChanged(String value) {
    loggy.info('onNickNameChanged(): $value');
  }

  void onPhoneChanged(PhoneNumber? value) {
    loggy.info('onPhoneChanged(): $value');
  }

  void onDateChanged(DateTime? value) {
    loggy.info('onDateChanged(): $value');
    dateNotifier.value = value;
  }

  void onGenderChange(Genders value) {
    loggy.info('onGenderChange');
  }

  void onUpdatePressed() {
    loggy.info('onUpdatePressed()');
  }

  @override
  Widget build(BuildContext context) => EditProfileView(controller: this);
}
