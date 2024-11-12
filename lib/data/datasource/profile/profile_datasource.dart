import 'package:ecoparking_flutter/model/account/profile.dart';

abstract class ProfileDataSource {
  Future<Map<String, dynamic>> updateProfile(Profile profile);
}
