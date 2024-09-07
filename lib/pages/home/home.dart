import 'package:ecoparking_flutter/pages/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<HomePage> {
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
    print('Location: ${locationData.latitude}, ${locationData.longitude}');

    center.value = LatLng(locationData.latitude!, locationData.longitude!);
  }

  @override
  Widget build(BuildContext context) => HomePageView(controller: this);
}
