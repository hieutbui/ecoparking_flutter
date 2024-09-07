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
  final center = ValueNotifier<LatLng?>(null);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    center.value = LatLng(locationData.latitude!, locationData.longitude!);
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
  }

  @override
  Widget build(BuildContext context) => HomePageView(controller: this);
}
