import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/search_map/search_map.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class SearchMapView extends StatelessWidget {
  final SearchMapController controller;

  const SearchMapView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.searchMap.getTitle(),
      onBackButtonPressed: controller.onBackButtonPressed,
      body: const Center(
        child: Text('Search Map'),
      ),
    );
  }
}
