import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/pages/search_map/search_map_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SearchMap extends StatefulWidget {
  const SearchMap({super.key});

  @override
  SearchMapController createState() => SearchMapController();
}

class SearchMapController extends State<SearchMap> with ControllerLoggy {
  final _recentSearchesBox = getIt.getAsync<Box<Parking>>();

  @override
  void initState() {
    super.initState();
    _getRecentSearches();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Parking>> _getRecentSearches() async {
    final box = await _recentSearchesBox;
    final list = box.values.toList();
    return list;
  }

  Future<void> addRecentSearch(Parking parking) async {
    final box = await _recentSearchesBox;
    await box.add(parking);
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
