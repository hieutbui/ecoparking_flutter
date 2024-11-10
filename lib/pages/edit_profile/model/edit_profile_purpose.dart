import 'package:ecoparking_flutter/config/app_paths.dart';

enum EditProfilePurpose {
  edit,
  create;

  String get title {
    switch (this) {
      case EditProfilePurpose.edit:
        return AppPaths.editProfile.getTitle();
      case EditProfilePurpose.create:
        return AppPaths.createProfile.getTitle();
    }
  }
}
