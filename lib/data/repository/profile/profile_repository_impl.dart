import 'package:ecoparking_flutter/data/datasource/profile/profile_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/profile/profile_repository.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _profileDataSource = getIt.get<ProfileDataSource>();

  @override
  Future<Map<String, dynamic>> updateProfile(Profile profile) {
    return _profileDataSource.updateProfile(profile);
  }

  @override
  Future<Map<String, dynamic>> getProfile(String id) {
    return _profileDataSource.getProfile(id);
  }
}
