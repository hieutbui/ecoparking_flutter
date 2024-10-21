import 'package:ecoparking_flutter/resource/image_paths.dart';

enum EWallet {
  vnpay;

  String getImagePath() {
    switch (this) {
      case EWallet.vnpay:
        return ImagePaths.imgVNPay;
    }
  }

  String getName() {
    switch (this) {
      case EWallet.vnpay:
        return 'VNPay';
    }
  }
}
