import 'package:ecoparking_flutter/config/env_loader.dart';
import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:ecoparking_flutter/pages/home/home_view_styles.dart';
import 'package:ecoparking_flutter/pages/home/widgets/rounded_button/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class HomePageView extends StatelessWidget {
  final HomeController controller;

  const HomePageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.center,
      builder: (context, center, child) {
        if (center == null) return child!;

        return Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: HomeViewStyles.initialZoom,
              ),
              children: [
                TileLayer(
                  tileProvider: CancellableNetworkTileProvider(),
                  urlTemplate: EnvLoader.mapURLTemplate,
                ),
                MarkerLayer(markers: [
                  Marker(
                    point: center,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                ]),
              ],
            ),
            Positioned(
              top: HomeViewStyles.topButtonRowPosition.top,
              right: HomeViewStyles.topButtonRowPosition.right,
              child: Row(
                children: [
                  RoundedButton(
                    icon: Icons.search,
                    onPressed: () {
                      debugPrint('Search button pressed');
                    },
                  ),
                  const SizedBox(width: HomeViewStyles.topButtonSpacing),
                  RoundedButton(
                    icon: Icons.notifications_none_rounded,
                    onPressed: () {
                      debugPrint('Notification button pressed');
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: HomeViewStyles.bottomButtonColumnPosition.bottom,
              right: HomeViewStyles.bottomButtonColumnPosition.right,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedButton(
                    icon: Icons.home,
                    onPressed: () {
                      debugPrint('Home button pressed');
                    },
                  ),
                  const SizedBox(height: HomeViewStyles.bottomButtonSpacing),
                  Container(
                    decoration:
                        HomeViewStyles.getFloatingButtonDecoration(context),
                    child: FloatingActionButton(
                      shape: HomeViewStyles.floatingButtonShape,
                      onPressed: () {
                        debugPrint('Floating action button pressed');
                      },
                      backgroundColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
