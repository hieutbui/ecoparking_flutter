import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:flutter/material.dart';

enum EWallet {
  vnpay,
  card;

  String getImagePath() {
    switch (this) {
      case EWallet.vnpay:
        return ImagePaths.imgVNPay;
      case EWallet.card:
        return '';
    }
  }

  IconData getIcon() {
    switch (this) {
      case EWallet.vnpay:
        return Icons.credit_card;
      case EWallet.card:
        return Icons.credit_card;
    }
  }

  String getName() {
    switch (this) {
      case EWallet.vnpay:
        return 'VNPay';
      case EWallet.card:
        return 'Card';
    }
  }
}
