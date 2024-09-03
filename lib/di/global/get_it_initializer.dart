import 'package:ecoparking_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class GetItInitializer {
  static final GetItInitializer _singleton = GetItInitializer._internal();

  factory GetItInitializer() {
    return _singleton;
  }

  GetItInitializer._internal();

  void setUp() {
    bindingGlobal();
    bindingDatasource();
    bindingDatasourceImpl();
    bindingRepositories();
    bindingInteractor();
    bindingController();

    debugPrint('GetItInitializer::setUp(): Setup successfully');
  }

  void bindingGlobal() {
    getIt.registerSingleton(ResponsiveUtils());
  }

  void bidingAPI() {}

  void bindingDatasource() {}

  void bindingDatasourceImpl() {}

  void bindingRepositories() {}

  void bindingInteractor() {}

  void bindingController() {}
}
