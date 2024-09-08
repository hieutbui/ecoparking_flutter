import 'package:ecoparking_flutter/data/datasource/markers/current_location_datasource.dart';
import 'package:ecoparking_flutter/data/datasource_impl/markers/current_location_datasource_impl.dart';
import 'package:ecoparking_flutter/data/repository/markers/current_location_repository_impl.dart';
import 'package:ecoparking_flutter/domain/repository/markers/current_location_repository.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/current_location_interactor.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/responsive.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class GetItInitializer with GetItLoggy {
  static final GetItInitializer _singleton = GetItInitializer._internal();

  factory GetItInitializer() {
    return _singleton;
  }

  GetItInitializer._internal();

  void setUp() {
    bindingGlobal();
    bindingDataSource();
    bindingDataSourceImpl();
    bindingRepositories();
    bindingInteractor();
    bindingController();

    loggy.info('setUp(): Setup successfully');
  }

  void bindingGlobal() {
    getIt.registerSingleton(ResponsiveUtils());

    loggy.info('bindingGlobal(): Setup successfully');
  }

  void bidingAPI() {
    loggy.info('bidingAPI(): Setup successfully');
  }

  void bindingDataSource() {
    loggy.info('bindingDataSource(): Setup successfully');
  }

  void bindingDataSourceImpl() {
    getIt.registerLazySingleton<CurrentLocationDataSource>(
      () => CurrentLocationDataSourceImpl(),
    );
    loggy.info('bindingDataSourceImpl(): Setup successfully');
  }

  void bindingRepositories() {
    getIt.registerLazySingleton<CurrentLocationRepository>(
      () => CurrentLocationRepositoryImpl(),
    );

    loggy.info('bindingRepositories(): Setup successfully');
  }

  void bindingInteractor() {
    getIt.registerLazySingleton<CurrentLocationInteractor>(
      () => CurrentLocationInteractor(),
    );
    loggy.info('bindingInteractor(): Setup successfully');
  }

  void bindingController() {
    loggy.info('bindingController(): Setup successfully');
  }
}
