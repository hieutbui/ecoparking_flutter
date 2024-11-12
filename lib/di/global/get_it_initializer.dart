import 'package:ecoparking_flutter/data/datasource/markers/current_location_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/profile/profile_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/register/register_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/tickets/ticket_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/user_favorite_parkings/user_favorite_parkings_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/user_vehicles/user_vehicles_datasource.dart';
import 'package:ecoparking_flutter/data/datasource_impl/markers/current_location_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/markers/parking_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/profile/profile_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/register/register_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/tickets/ticket_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/user_favorite_parkings/user_favorite_parkings_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/user_vehicles/user_vehicles_datasource_impl.dart';
import 'package:ecoparking_flutter/data/repository/markers/current_location_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/markers/parking_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/profile/profile_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/register/register_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/tickets/ticket_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/user_favorite_parkings/user_favorite_parkings_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/user_vehicles/user_vehicles_repository_impl.dart';
import 'package:ecoparking_flutter/domain/repository/markers/current_location_repository.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:ecoparking_flutter/domain/repository/profile/profile_repository.dart';
import 'package:ecoparking_flutter/domain/repository/register/register_repository.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';
import 'package:ecoparking_flutter/domain/repository/user_favorite_parkings/user_favorite_parkings_repository.dart';
import 'package:ecoparking_flutter/domain/repository/user_vehicles/user_vehicles_repository.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/services/parking_service.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/current_location_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/parking_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/update_profile_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/register/register_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/ticket_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/user_favorite_parkings_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/vehicles/user_vehicles_interactor.dart';
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
    bindingServices();
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
    getIt.registerLazySingleton<ParkingDataSource>(
      () => ParkingsDataSourceImpl(),
    );
    getIt.registerLazySingleton<UserVehiclesDatasource>(
      () => UserVehiclesDatasourceImpl(),
    );
    getIt.registerLazySingleton<TicketDataSource>(
      () => TicketDataSourceImpl(),
    );
    getIt.registerLazySingleton<UserFavoriteParkingsDatasource>(
      () => UserFavoriteParkingsDatasourceImpl(),
    );
    getIt.registerLazySingleton<RegisterDataSource>(
      () => RegisterDataSourceImpl(),
    );
    getIt.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(),
    );
    loggy.info('bindingDataSourceImpl(): Setup successfully');
  }

  void bindingRepositories() {
    getIt.registerLazySingleton<CurrentLocationRepository>(
      () => CurrentLocationRepositoryImpl(),
    );
    getIt.registerLazySingleton<ParkingRepository>(
      () => ParkingRepositoryImpl(),
    );
    getIt.registerLazySingleton<UserVehiclesRepository>(
      () => UserVehiclesRepositoryImpl(),
    );
    getIt.registerLazySingleton<TicketRepository>(
      () => TicketRepositoryImpl(),
    );
    getIt.registerLazySingleton<UserFavoriteParkingsRepository>(
      () => UserFavoriteParkingsRepositoryImpl(),
    );
    getIt.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(),
    );
    getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(),
    );
    loggy.info('bindingRepositories(): Setup successfully');
  }

  void bindingInteractor() {
    getIt.registerLazySingleton<CurrentLocationInteractor>(
      () => CurrentLocationInteractor(),
    );
    getIt.registerLazySingleton<ParkingInteractor>(
      () => ParkingInteractor(),
    );
    getIt.registerLazySingleton<UserVehiclesInteractor>(
      () => UserVehiclesInteractor(),
    );
    getIt.registerLazySingleton<TicketInteractor>(
      () => TicketInteractor(),
    );
    getIt.registerLazySingleton<UserFavoriteParkingsInteractor>(
      () => UserFavoriteParkingsInteractor(),
    );
    getIt.registerLazySingleton<RegisterInteractor>(
      () => RegisterInteractor(),
    );
    getIt.registerLazySingleton<UpdateProfileInteractor>(
      () => UpdateProfileInteractor(),
    );
    loggy.info('bindingInteractor(): Setup successfully');
  }

  void bindingServices() {
    getIt.registerSingleton<ParkingService>(ParkingService());
    getIt.registerSingleton<BookingService>(BookingService());
    getIt.registerSingleton<AccountService>(AccountService());
    loggy.info('bindingServices(): Setup successfully');
  }

  void bindingController() {
    loggy.info('bindingController(): Setup successfully');
  }
}
