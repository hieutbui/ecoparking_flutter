import 'package:ecoparking_flutter/config/app_config.dart';
import 'package:ecoparking_flutter/config/env_loader.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_current_location_state.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_parkings_state.dart';
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
      valueListenable: controller.currentLocationNotifier,
      builder: (context, notifier, child) {
        if (notifier is GetCurrentLocationInitial) return child!;

        if (notifier is GetCurrentLocationSuccess) {
          final center =
              controller.convertLocationDataToLatLng(notifier.currentLocation);
          return Stack(
            children: [
              FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: HomeViewStyles.initialZoom,
                  onMapReady: () => controller.onMapReady(center),
                ),
                children: [
                  TileLayer(
                    tileProvider: CancellableNetworkTileProvider(),
                    urlTemplate: EnvLoader.mapURLTemplate,
                    userAgentPackageName: AppConfig.userAgentPackageName,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: center,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.parkingNotifier,
                    builder: (context, notifier, child) {
                      if (notifier is GetParkingsSuccess) {
                        return MarkerLayer(
                          markers: controller.convertParkingsToMarkers(
                            context,
                            notifier.parkings,
                          ),
                        );
                      }
                      return child!;
                    },
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
              Positioned(
                top: HomeViewStyles.topButtonRowPosition.top,
                right: HomeViewStyles.topButtonRowPosition.right,
                child: Row(
                  children: [
                    RoundedButton(
                      icon: Icons.search,
                      onPressed: controller.onSearchPressed,
                    ),
                    const SizedBox(width: HomeViewStyles.topButtonSpacing),
                    RoundedButton(
                      icon: Icons.notifications_none_rounded,
                      onPressed: controller.onNotificationPressed,
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
                      onPressed: controller.onHomePressed,
                    ),
                    const SizedBox(height: HomeViewStyles.bottomButtonSpacing),
                    Container(
                      decoration:
                          HomeViewStyles.getFloatingButtonDecoration(context),
                      child: FloatingActionButton(
                        shape: HomeViewStyles.floatingButtonShape,
                        onPressed: controller.onCurrentLocationPressed,
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
        }

        return child!;
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
