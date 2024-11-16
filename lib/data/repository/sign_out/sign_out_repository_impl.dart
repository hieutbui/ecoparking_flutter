import 'package:ecoparking_flutter/data/datasource/sign_out/sign_out_datasource.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/repository/sign_out/sign_out_repository.dart';

class SignOutRepositoryImpl implements SignOutRepository {
  final SignOutDataSource _signOutDataSource = getIt.get<SignOutDataSource>();

  @override
  Future<void> signOut() {
    return _signOutDataSource.signOut();
  }
}
