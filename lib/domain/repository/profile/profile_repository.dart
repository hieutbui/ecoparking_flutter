import 'package:ecoparking_flutter/model/account/profile.dart';

abstract class ProfileRepository {
  Future<Map<String, dynamic>> updateProfile(Profile profile);
}
