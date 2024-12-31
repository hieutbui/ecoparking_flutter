import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:ecoparking_flutter/pages/home/widgets/rounded_button/rounded_button.dart';
import 'package:ecoparking_flutter/pages/home/widgets/search_parking/recent_search_list.dart';
import 'package:ecoparking_flutter/pages/home/widgets/search_parking/search_result_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchParkingAnchor extends StatelessWidget {
  final HomeController controller;
  final SearchController searchController;

  const SearchParkingAnchor({
    super.key,
    required this.controller,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchController,
      builder: (builderContext, searchBuilderController) {
        return RoundedButton(
          icon: Icons.search,
          onPressed: () => controller.onSearchPressed(searchBuilderController),
        );
      },
      viewOnChanged: (value) => controller.onSearchChanged(value),
      isFullScreen: true,
      viewBackgroundColor: Theme.of(context).colorScheme.surface,
      viewHintText: "Tìm kiếm bãi đỗ xe",
      headerHintStyle: GoogleFonts.poppins(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        letterSpacing: 0.0,
      ),
      dividerColor: Theme.of(context).colorScheme.tertiary,
      suggestionsBuilder:
          (suggestionsBuilderContext, suggestionBuilderController) {
        if (suggestionBuilderController.text.isEmpty) {
          return [
            RecentSearchList(
              controller: controller,
              onRecentTap: (parking) {
                controller.onSuggestionPressed(
                  suggestionBuilderController,
                  parking,
                );
              },
            ),
          ];
        }

        return [
          SearchResultList(controller: controller),
        ];
      },
    );
  }
}
