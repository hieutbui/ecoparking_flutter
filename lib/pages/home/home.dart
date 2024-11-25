import 'dart:async';
import 'dart:math' hide Point;
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/services/parking_service.dart';
import 'package:ecoparking_flutter/domain/state/markers/find_nearby_parkings_state.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_current_location_state.dart';
import 'package:ecoparking_flutter/domain/state/profile/get_profile_state.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/current_location_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/find_nearby_parkings_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/get_profile_interactor.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/home/home_view.dart';
import 'package:ecoparking_flutter/pages/home/home_view_styles.dart';
import 'package:ecoparking_flutter/pages/home/model/parking_bottom_sheet_action.dart';
import 'package:ecoparking_flutter/pages/home/widgets/parking_bottom_sheet_builder/parking_bottom_sheet_builder.dart';
import 'package:ecoparking_flutter/utils/bottom_sheet_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geobase/geobase.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<HomePage> with ControllerLoggy {
  final CurrentLocationInteractor _currentLocationInteractor =
      getIt.get<CurrentLocationInteractor>();
  final GetProfileInteractor _getProfileInteractor =
      getIt.get<GetProfileInteractor>();
  final FindNearbyParkingsInteractor _findNearbyParkingsInteractor =
      getIt.get<FindNearbyParkingsInteractor>();
  final ParkingService parkingService = getIt.get<ParkingService>();
  final BookingService bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final currentLocationNotifier = ValueNotifier<GetCurrentLocationState>(
    const GetCurrentLocationInitial(),
  );
  final findNearbyParkingsNotifier = ValueNotifier<FindNearbyParkingsState>(
    const FindNearbyParkingsInitial(),
  );

  final MapController mapController = MapController();

  StreamSubscription? _currentLocationSubscription;
  StreamSubscription? _getUserProfileSubscription;
  StreamSubscription? _findNearbyParkingsSubscription;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getUserProfile();
  }

  @override
  void dispose() {
    mapController.dispose();
    _clearSubscriptions();
    _disposeNotifier();
    super.dispose();
  }

  void _clearSubscriptions() {
    _currentLocationSubscription?.cancel();
    _getUserProfileSubscription?.cancel();
    _findNearbyParkingsSubscription?.cancel();
    _currentLocationSubscription = null;
    _getUserProfileSubscription = null;
  }

  void _disposeNotifier() {
    currentLocationNotifier.dispose();
    findNearbyParkingsNotifier.dispose();
  }

  void _getUserProfile() {
    loggy.info('_getUserProfile()');
    if (_accountService.profile != null) {
      return;
    }

    final user = _accountService.user ?? SupabaseUtils().auth.currentUser;
    final userId = user?.id;

    if (userId == null) {
      loggy.error('_getUserProfile(): user is null');
      return;
    }

    _getUserProfileSubscription = _getProfileInteractor.execute(userId).listen(
          (event) => event.fold(
            (failure) => _handleGetProfileFailure(failure),
            (success) => _handleGetProfileSuccess(success),
          ),
        );
  }

  void _getCurrentLocation() async {
    _currentLocationSubscription = _currentLocationInteractor.execute().listen(
      (event) {
        event.fold(
          (failure) => _handleGetCurrentLocationFailure(failure),
          (success) => _handleGetCurrentLocationSuccess(success),
        );
      },
    );
  }

  void findNearbyParking(LatLng userLocation) async {
    _findNearbyParkingsSubscription = _findNearbyParkingsInteractor
        .execute(
          Point(
            Position.create(
              x: userLocation.longitude,
              y: userLocation.latitude,
            ),
          ),
          _getNearbyMaxDistance(userLocation),
        )
        .listen(
          (event) => event.fold(
            (failure) => _handleFindNearbyParkingsFailure(failure),
            (success) => _handleFindNearbyParkingsSuccess(success),
          ),
        );
  }

  LatLng convertLocationDataToLatLng(geolocator.Position locationData) {
    return LatLng(locationData.latitude, locationData.longitude);
  }

  List<Marker> convertParkingsToMarkers(
    BuildContext context,
    List<Parking> parkings,
  ) {
    return parkings.map((parking) {
      final LatLng latLng = LatLng(
        parking.geolocation.position.y,
        parking.geolocation.position.x,
      );
      return Marker(
        point: latLng,
        child: GestureDetector(
          onTap: () => onParkingMarkerPressed(context, parking),
          child: Container(
            width: HomeViewStyles.parkingMarkerOuterSize,
            height: HomeViewStyles.parkingMarkerOuterSize,
            decoration: HomeViewStyles.getParkingOuterMarkerDecoration(context),
            child: Center(
              child: Container(
                width: HomeViewStyles.parkingMarkerInnerSize,
                height: HomeViewStyles.parkingMarkerInnerSize,
                decoration:
                    HomeViewStyles.getParkingInnerMarkerDecoration(context),
                child: Icon(
                  Icons.local_parking,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  size: HomeViewStyles.parkingMarkerIconSize,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  void onSearchPressed() {
    loggy.warning('Search button pressed');
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.searchMap,
    );
  }

  void onNotificationPressed() {
    loggy.info('Notification button pressed');
  }

  void onHomePressed() {
    loggy.info('Home button pressed');
  }

  void onCurrentLocationPressed() {
    loggy.info('Current location button pressed');
    _getCurrentLocation();
  }

  void onParkingMarkerPressed(BuildContext context, Parking parking) async {
    loggy.info('Parking marker pressed', parking);

    final ParkingBottomSheetAction? action =
        await BottomSheetUtils.show<ParkingBottomSheetAction>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      showDragHandle: true,
      maxHeight: MediaQuery.sizeOf(context).height * 0.65,
      builder: (context) => ParkingBottomSheetBuilder.build(context, parking),
    );

    if (!context.mounted) return;

    if (action == null) return;

    if (action == ParkingBottomSheetAction.details) {
      loggy.info('Parking details pressed');

      parkingService.selectParking(parking);

      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.parkingDetails,
      );
      return;
    } else if (action == ParkingBottomSheetAction.bookNow) {
      loggy.info('Book now pressed');

      bookingService.setParking(parking);
      bookingService.setParkingFeeType(ParkingFeeTypes.hourly);

      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.bookingDetails,
      );
    }
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371e3;
    final double lat1 = start.latitude * (pi / 180);
    final double lat2 = end.latitude * (pi / 180);
    final double deltaLat = (end.latitude - start.latitude) * (pi / 180);
    final double deltaLng = (end.longitude - start.longitude) * (pi / 180);

    final double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _getNearbyMaxDistance(LatLng currentLocation) {
    final LatLng userLocation = currentLocation;
    final LatLngBounds bounds = mapController.camera.visibleBounds;

    final List<double> distances = [
      _calculateDistance(userLocation, bounds.southWest),
      _calculateDistance(userLocation, bounds.northEast),
      _calculateDistance(
        userLocation,
        LatLng(bounds.southWest.latitude, bounds.northEast.longitude),
      ),
      _calculateDistance(
        userLocation,
        LatLng(bounds.northEast.latitude, bounds.southWest.longitude),
      ),
    ];

    return distances.reduce((a, b) => a > b ? a : b);
  }

  void onMapReady(LatLng userLocation) {
    loggy.info('onMapReady()');

    findNearbyParking(userLocation);
  }

  void onMapEvent(MapEvent event) {
    loggy.info('onMapEvent() event: $event');
  }

  void onPositionChanged(MapCamera camera, bool hasGesture) {
    loggy
        .info('onPositionChanged() position: $camera, hasGesture: $hasGesture');
    findNearbyParking(camera.center);
  }

  void _handleFindNearbyParkingsFailure(Failure failure) {
    loggy.error('handleFindNearbyParkingsFailure(): failure: $failure');
    if (failure is FindNearbyParkingsFailure) {
      findNearbyParkingsNotifier.value = failure;
    } else {
      findNearbyParkingsNotifier.value = const FindNearbyParkingsIsEmpty();
    }
  }

  void _handleFindNearbyParkingsSuccess(Success success) {
    loggy.info('handleFindNearbyParkingsSuccess(): success');
    if (success is FindNearbyParkingsSuccess) {
      findNearbyParkingsNotifier.value = success;
    } else {
      loggy.info('handleFindNearbyParkingsSuccess(): success is empty');
      findNearbyParkingsNotifier.value = const FindNearbyParkingsIsEmpty();
    }
  }

  void _handleGetProfileSuccess(Success success) {
    loggy.info('handleGetProfileSuccess(): $success');

    if (success is GetProfileSuccess) {
      loggy.info('handleGetProfileSuccess(): ${success.profile}');
      _accountService.setProfile(success.profile);
    }
  }

  void _handleGetProfileFailure(Failure failure) {
    loggy.error('handleGetProfileFailure(): $failure');

    if (failure is GetProfileFailure) {
      loggy.error(
        'handleGetProfileFailure():: GetProfileFailure: ${failure.exception}',
      );
    } else {
      loggy.error('handleGetProfileFailure():: Unknown failure: $failure');
    }
  }

  void _handleGetCurrentLocationFailure(Failure failure) {
    loggy.error('handleGetCurrentLocationFailure(): failure: $failure');
    if (failure is GetCurrentLocationFailure) {
      currentLocationNotifier.value = failure;
    } else {
      currentLocationNotifier.value = const GetCurrentLocationIsEmpty();
    }
  }

  void _handleGetCurrentLocationSuccess(Success success) {
    loggy.info('handleGetCurrentLocationSuccess(): success');
    if (success is GetCurrentLocationSuccess) {
      currentLocationNotifier.value = success;
    } else {
      currentLocationNotifier.value = const GetCurrentLocationIsEmpty();
    }
  }

  @override
  Widget build(BuildContext context) => HomePageView(controller: this);
}
