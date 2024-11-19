import 'dart:typed_data';
import 'package:ecoparking_flutter/model/account/profile.dart';

abstract class ProfileDataSource {
  Future<Map<String, dynamic>> updateProfile(Profile profile);
  Future<Map<String, dynamic>> getProfile(String id);
  Future<String> uploadAvatarOnWeb(
    String id,
    Uint8List avatar,
    String fileExtension,
  );
  Future<String> createAvatarSignedURL(String filePath);
}
