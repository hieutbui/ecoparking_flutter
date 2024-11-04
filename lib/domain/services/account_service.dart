import 'package:ecoparking_flutter/model/account/account.dart';

class AccountService {
  Account? _account;

  Account? get account => _account;

  void setAccount(Account account) {
    _account = account;
  }

  void clear() {
    _account = null;
  }
}
