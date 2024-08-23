import 'package:ecoparking_flutter/pages/resource/assets_paths.dart';

class ImagePaths {
  static String get imgToyotaLandCruiser =>
      _getImagePath('img_toyota_land_cruiser.png');
  static String get imgGoogle => _getImagePath('img_google.svg');
  static String get icFilter => _getIconPath('ic_filter.svg');
  static String get icDialogSuccessful =>
      'assets/images/img_dialog_successful.svg';

  static String _getImagePath(String imageName) {
    return AssetsPaths.images + imageName;
  }

  static String _getIconPath(String iconName) {
    return AssetsPaths.icons + iconName;
  }

  static String _getAssetPath(String assetName) {
    return AssetsPaths.assets + assetName;
  }
}
