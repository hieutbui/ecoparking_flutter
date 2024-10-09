import 'package:ecoparking_flutter/resource/assets_paths.dart';

class ImagePaths {
  static String get imgToyotaLandCruiser =>
      _getImagePath('img_toyota_land_cruiser.png');
  static String get imgGoogle => _getImagePath('img_google.svg');
  static String get imgDialogSuccessful =>
      _getImagePath('img_dialog_successful.svg');
  static String get imgOnlinePayment => _getImagePath('img_online_payment.png');
  static String get imgCarModel => _getImagePath('img_car_model.png');

  static String get icFilter => _getIconPath('ic_filter.svg');
  static String get icPerson => _getIconPath('ic_person.svg');

  static String _getImagePath(String imageName) {
    return AssetsPaths.images + imageName;
  }

  static String _getIconPath(String iconName) {
    return AssetsPaths.icons + iconName;
  }
}
