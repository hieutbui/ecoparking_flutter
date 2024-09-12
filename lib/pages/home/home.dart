import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_current_location_state.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_parkings_state.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/current_location_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/parking_interactor.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/pages/home/home_view.dart';
import 'package:ecoparking_flutter/pages/home/home_view_styles.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<HomePage> with ControllerLoggy {
  final CurrentLocationInteractor _currentLocationInteractor =
      getIt.get<CurrentLocationInteractor>();
  final ParkingInteractor _parkingInteractor = getIt.get<ParkingInteractor>();

  final currentLocationNotifier = ValueNotifier<GetCurrentLocationState>(
    const GetCurrentLocationInitial(),
  );
  final parkingNotifier = ValueNotifier<GetParkingsState>(
    const GetParkingsInitial(),
  );

  StreamSubscription? _currentLocationSubscription;
  StreamSubscription? _parkingSubscription;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getParkings();
  }

  @override
  void dispose() {
    super.dispose();
    currentLocationNotifier.dispose();
    parkingNotifier.dispose();
    _currentLocationSubscription?.cancel();
    _parkingSubscription?.cancel();
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

  void _getParkings() async {
    _parkingSubscription = _parkingInteractor.execute().listen(
      (event) {
        event.fold(
          (failure) => _handleGetParkingsFailure(failure),
          (success) => _handleGetParkingsSuccess(success),
        );
      },
    );
  }

  void _handleGetCurrentLocationFailure(Failure failure) {
    loggy.error('handleGetCurrentLocationFailure(): failure: $failure');
    if (failure is GetCurrentLocationFailure) {
      currentLocationNotifier.value = failure;
    } else {
      currentLocationNotifier.value = const GetCurrentLocationIsEmpty();
    }
  }

  void _handleGetParkingsFailure(Failure failure) {
    loggy.error('handleGetParkingsFailure(): failure: $failure');
    if (failure is GetParkingsFailure) {
      parkingNotifier.value = failure;
    } else {
      parkingNotifier.value = const GetParkingsIsEmpty();
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

  void _handleGetParkingsSuccess(Success success) {
    loggy.info('handleGetParkingsSuccess(): success');
    if (success is GetParkingsSuccess) {
      parkingNotifier.value = success;
    } else {
      parkingNotifier.value = const GetParkingsIsEmpty();
    }
  }

  LatLng convertLocationDataToLatLng(LocationData locationData) {
    return LatLng(locationData.latitude!, locationData.longitude!);
  }

  List<Marker> convertParkingsToMarkers(
    BuildContext context,
    List<Parking> parkings,
  ) {
    return parkings.map((parking) {
      return Marker(
        point: LatLng(parking.latitude, parking.longitude),
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

  void onParkingMarkerPressed(BuildContext context, Parking parking) {
    loggy.info('Parking marker pressed', parking);
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.parkingDetails.path,
      params: parking,
    );
  }

  @override
  Widget build(BuildContext context) => HomePageView(controller: this);
}
