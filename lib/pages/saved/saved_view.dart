import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/get_user_favorite_parkings.dart';
import 'package:ecoparking_flutter/pages/saved/saved.dart';
import 'package:ecoparking_flutter/pages/saved/widgets/saved_parkings_card.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class SavedPageView extends StatelessWidget {
  final SavedController controller;

  const SavedPageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.saved.getTitle(),
      showBackButton: false,
      body: ValueListenableBuilder(
        valueListenable: controller.userFavoriteParkingsNotifier,
        builder: (context, userFavoriteParkings, child) {
          if (userFavoriteParkings is GetUserFavoriteParkingsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (userFavoriteParkings is GetUserFavoriteParkingsIsEmpty) {
            return Center(
              child: Text(
                'No favorite parkings',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            );
          }

          if (userFavoriteParkings is GetUserFavoriteParkingsFailure) {
            return Center(
              child: Text(
                'Failed to load favorite parkings: ${userFavoriteParkings.exception}',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            );
          }

          if (userFavoriteParkings is GetUserFavoriteParkingsSuccess) {
            final parkings = userFavoriteParkings.favoriteParkings;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: parkings.length,
              itemBuilder: (context, index) {
                return SavedParkingsCard(
                  favoriteParking: parkings[index],
                  onRemoveFavoriteParking: controller.onRemoveFavoriteParking,
                );
              },
            );
          }

          return child!;
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}
