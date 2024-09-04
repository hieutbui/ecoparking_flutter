import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class HomePageView extends StatelessWidget {
  final HomeController controller;

  const HomePageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(50.5, 30.51),
        initialZoom: 5,
      ),
      children: [
        TileLayer(
          tileProvider: CancellableNetworkTileProvider(),
          urlTemplate: dotenv.get('MAPBOX_URL_TEMPLATE'),
        )
      ],
    );
  }
}
