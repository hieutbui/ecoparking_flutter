import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_current_location_state.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/current_location_interactor.dart';
import 'package:ecoparking_flutter/pages/home/home_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';
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

  final currentLocationNotifier = ValueNotifier<GetCurrentLocationState>(
    const GetCurrentLocationInitial(),
  );

  StreamSubscription? _currentLocationSubscription;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    currentLocationNotifier.dispose();
    _currentLocationSubscription?.cancel();
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

  LatLng convertLocationDataToLatLng(LocationData locationData) {
    return LatLng(locationData.latitude!, locationData.longitude!);
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

  @override
  Widget build(BuildContext context) => HomePageView(controller: this);
}
