import 'package:ecoparking_flutter/model/account/profile.dart';

abstract class ProfileRepository {
  Future<Map<String, dynamic>> updateProfile(Profile profile);
  Future<Map<String, dynamic>> getProfile(String id);
}
