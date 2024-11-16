import 'package:ecoparking_flutter/resource/assets_paths.dart';

class ImagePaths {
  static String get imgToyotaLandCruiser =>
      _getImagePath('img_toyota_land_cruiser.png');
  static String get imgGoogle => _getImagePath('img_google.svg');
  static String get imgDialogSuccessful =>
      _getImagePath('img_dialog_successful.svg');
  static String get imgOnlinePayment => _getImagePath('img_online_payment.png');
  static String get imgCarModel => _getImagePath('img_car_model.png');
  static String get imgVNPay => _getImagePath('img_vnpay.png');
  static String get imgDialogError => _getImagePath('img_dialog_error.svg');

  static String get icFilter => _getIconPath('ic_filter.svg');
  static String get icPerson => _getIconPath('ic_person.svg');
  static String get icLoginFB => _getIconPath('ic_login_fb.svg');
  static String get icLoginGG => _getIconPath('ic_login_gg.svg');

  static String _getImagePath(String imageName) {
    return AssetsPaths.images + imageName;
  }

  static String _getIconPath(String iconName) {
    return AssetsPaths.icons + iconName;
  }
}
