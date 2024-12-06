import 'package:ecoparking_flutter/data/datasource/login/login_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/markers/current_location_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/markers/parking_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/payment/payment_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/profile/profile_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/register/register_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/search_parking/search_parking_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/sign_out/sign_out_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/tickets/ticket_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/user_favorite_parkings/user_favorite_parkings_datasource.dart';
import 'package:ecoparking_flutter/data/datasource/user_vehicles/user_vehicles_datasource.dart';
import 'package:ecoparking_flutter/data/datasource_impl/login/login_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/markers/current_location_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/markers/parking_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/payment/payment_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/profile/profile_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/register/register_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/search_parking/search_parking_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/sign_out/sign_out_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/tickets/ticket_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/user_favorite_parkings/user_favorite_parkings_datasource_impl.dart';
import 'package:ecoparking_flutter/data/datasource_impl/user_vehicles/user_vehicles_datasource_impl.dart';
import 'package:ecoparking_flutter/data/repository/login/login_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/markers/current_location_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/markers/parking_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/payment/payment_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/profile/profile_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/register/register_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/search_parking/search_parking_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/sign_out/sign_out_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/tickets/ticket_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/user_favorite_parkings/user_favorite_parkings_repository_impl.dart';
import 'package:ecoparking_flutter/data/repository/user_vehicles/user_vehicles_repository_impl.dart';
import 'package:ecoparking_flutter/di/global/hive_initializer.dart';
import 'package:ecoparking_flutter/di/global/network_di.dart';
import 'package:ecoparking_flutter/domain/repository/login/login_repository.dart';
import 'package:ecoparking_flutter/domain/repository/markers/current_location_repository.dart';
import 'package:ecoparking_flutter/domain/repository/markers/parking_repository.dart';
import 'package:ecoparking_flutter/domain/repository/payment/payment_repository.dart';
import 'package:ecoparking_flutter/domain/repository/profile/profile_repository.dart';
import 'package:ecoparking_flutter/domain/repository/register/register_repository.dart';
import 'package:ecoparking_flutter/domain/repository/search_parking/search_parking_repository.dart';
import 'package:ecoparking_flutter/domain/repository/sign_out/sign_out_repository.dart';
import 'package:ecoparking_flutter/domain/repository/tickets/ticket_repository.dart';
import 'package:ecoparking_flutter/domain/repository/user_favorite_parkings/user_favorite_parkings_repository.dart';
import 'package:ecoparking_flutter/domain/repository/user_vehicles/user_vehicles_repository.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/services/parking_service.dart';
import 'package:ecoparking_flutter/domain/services/register_service.dart';
import 'package:ecoparking_flutter/domain/usecase/login/login_with_email_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/current_location_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/find_nearby_parkings_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/payment/confirm_payment_intent_web_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/payment/create_payment_intent_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/get_profile_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/update_profile_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/register/register_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/register/verify_email_otp_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/search_parking/search_parking_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/sign_out/sign_out_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/cancel_ticket_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/create_ticket_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/get_ticket_info_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/ticket_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/user_favorite_parkings_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/vehicles/user_vehicles_interactor.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/responsive.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

class GetItInitializer with GetItLoggy {
  static final GetItInitializer _singleton = GetItInitializer._internal();

  factory GetItInitializer() {
    return _singleton;
  }

  GetItInitializer._internal();

  void setUp() {
    bindingGlobal();

    loggy.info('setUp(): Setup successfully');
  }

  void bindingGlobal() {
    NetworkDi().bind();
    bindingHiveBoxes();
    bindingAPI();
    bindingDataSource();
    bindingDataSourceImpl();
    bindingRepositories();
    bindingInteractor();
    bindingServices();
    bindingController();
    getIt.registerSingleton(ResponsiveUtils());

    loggy.info('bindingGlobal(): Setup successfully');
  }

  void bindingHiveBoxes() {
    getIt.registerLazySingletonAsync<Box<Parking>>(
      () async => HiveInitializer.openRecentSearchesBox(),
    );
    loggy.info('bindingHiveBoxes(): Setup successfully');
  }

  void bindingAPI() {
    loggy.info('bidingAPI(): Setup successfully');
  }

  void bindingDataSource() {
    getIt.registerFactory<CurrentLocationDataSource>(
      () => CurrentLocationDataSourceImpl(),
    );
    getIt.registerFactory<ParkingDataSource>(
      () => ParkingsDataSourceImpl(),
    );
    getIt.registerFactory<UserVehiclesDataSource>(
      () => UserVehiclesDataSourceImpl(),
    );
    getIt.registerFactory<TicketDataSource>(
      () => TicketDataSourceImpl(),
    );
    getIt.registerFactory<UserFavoriteParkingsDataSource>(
      () => UserFavoriteParkingsDataSourceImpl(),
    );
    getIt.registerFactory<RegisterDataSource>(
      () => RegisterDataSourceImpl(),
    );
    getIt.registerFactory<ProfileDataSource>(
      () => ProfileDataSourceImpl(),
    );
    getIt.registerFactory<LoginDataSource>(
      () => LoginDataSourceImpl(),
    );
    getIt.registerFactory<SignOutDataSource>(
      () => SignOutDataSourceImpl(),
    );
    getIt.registerFactory<SearchParkingDataSource>(
      () => SearchParkingDataSourceImpl(),
    );
    getIt.registerFactory<PaymentDataSource>(
      () => PaymentDataSourceImpl(),
    );
    loggy.info('bindingDataSource(): Setup successfully');
  }

  void bindingDataSourceImpl() {
    getIt.registerFactory<CurrentLocationDataSourceImpl>(
      () => CurrentLocationDataSourceImpl(),
    );
    getIt.registerFactory<ParkingsDataSourceImpl>(
      () => ParkingsDataSourceImpl(),
    );
    getIt.registerFactory<UserVehiclesDataSourceImpl>(
      () => UserVehiclesDataSourceImpl(),
    );
    getIt.registerFactory<TicketDataSourceImpl>(
      () => TicketDataSourceImpl(),
    );
    getIt.registerFactory<UserFavoriteParkingsDataSourceImpl>(
      () => UserFavoriteParkingsDataSourceImpl(),
    );
    getIt.registerFactory<RegisterDataSourceImpl>(
      () => RegisterDataSourceImpl(),
    );
    getIt.registerFactory<ProfileDataSourceImpl>(
      () => ProfileDataSourceImpl(),
    );
    getIt.registerFactory<LoginDataSourceImpl>(
      () => LoginDataSourceImpl(),
    );
    getIt.registerFactory<SignOutDataSourceImpl>(
      () => SignOutDataSourceImpl(),
    );
    getIt.registerFactory<SearchParkingDataSourceImpl>(
      () => SearchParkingDataSourceImpl(),
    );
    getIt.registerFactory<PaymentDataSourceImpl>(
      () => PaymentDataSourceImpl(),
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
    getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(),
    );
    getIt.registerLazySingleton<SignOutRepository>(
      () => SignOutRepositoryImpl(),
    );
    getIt.registerLazySingleton<SearchParkingRepository>(
      () => SearchParkingRepositoryImpl(),
    );
    getIt.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(),
    );
    loggy.info('bindingRepositories(): Setup successfully');
  }

  void bindingInteractor() {
    getIt.registerLazySingleton<CurrentLocationInteractor>(
      () => CurrentLocationInteractor(),
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
    getIt.registerLazySingleton<LoginWithEmailInteractor>(
      () => LoginWithEmailInteractor(),
    );
    getIt.registerLazySingleton<SignOutInteractor>(
      () => SignOutInteractor(),
    );
    getIt.registerLazySingleton<VerifyEmailOtpInteractor>(
      () => VerifyEmailOtpInteractor(),
    );
    getIt.registerLazySingleton<GetProfileInteractor>(
      () => GetProfileInteractor(),
    );
    getIt.registerLazySingleton<FindNearbyParkingsInteractor>(
      () => FindNearbyParkingsInteractor(),
    );
    getIt.registerLazySingleton<SearchParkingInteractor>(
      () => SearchParkingInteractor(),
    );
    getIt.registerLazySingleton<CreatePaymentIntentInteractor>(
      () => CreatePaymentIntentInteractor(),
    );
    getIt.registerLazySingleton<ConfirmPaymentIntentWebInteractor>(
      () => ConfirmPaymentIntentWebInteractor(),
    );
    getIt.registerLazySingleton<CreateTicketInteractor>(
      () => CreateTicketInteractor(),
    );
    getIt.registerLazySingleton<GetTicketInfoInteractor>(
      () => GetTicketInfoInteractor(),
    );
    getIt.registerLazySingleton<CancelTicketInteractor>(
      () => CancelTicketInteractor(),
    );
    loggy.info('bindingInteractor(): Setup successfully');
  }

  void bindingServices() {
    getIt.registerSingleton<ParkingService>(ParkingService());
    getIt.registerSingleton<BookingService>(BookingService());
    getIt.registerSingleton<AccountService>(AccountService());
    getIt.registerSingleton<RegisterService>(RegisterService());
    loggy.info('bindingServices(): Setup successfully');
  }

  void bindingController() {
    loggy.info('bindingController(): Setup successfully');
  }
}
