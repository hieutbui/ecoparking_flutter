import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/search_map/search_map_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class SearchMap extends StatefulWidget {
  const SearchMap({super.key});

  @override
  SearchMapController createState() => SearchMapController();
}

class SearchMapController extends State<SearchMap> with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('Back button pressed');
    NavigationUtils.navigateTo(
      context: scaffoldContext,
      path: AppPaths.home,
    );
  }

  @override
  Widget build(BuildContext context) => SearchMapView(controller: this);
}
