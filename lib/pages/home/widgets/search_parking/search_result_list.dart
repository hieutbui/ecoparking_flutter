import 'package:ecoparking_flutter/domain/state/search_parking/search_parking_state.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_by.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_order.dart';
import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:ecoparking_flutter/pages/home/widgets/search_parking/parking_info_row.dart';
import 'package:flutter/material.dart';

class SearchResultList extends StatelessWidget {
  final HomeController controller;

  const SearchResultList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 16.0,
          ),
          child: Text(
            'Search Results',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            bottom: 8.0,
          ),
          child: Row(
            children: <Widget>[
              Text(
                'Sort by: ',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const SizedBox(width: 8.0),
              ValueListenableBuilder(
                valueListenable: controller.sortByNotifier,
                builder: (sortByContext, sortBySnapshot, child) {
                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                    ),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: controller.onSortByPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            sortBySnapshot.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(width: 2.0),
                          Icon(
                            sortBySnapshot == ParkingSortBy.distance
                                ? Icons.alt_route_rounded
                                : Icons.attach_money_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8.0),
              ValueListenableBuilder(
                valueListenable: controller.sortOrderNotifier,
                builder: (sortByContext, sortOrderSnapshot, child) {
                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                    ),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: controller.onSortOrderPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            sortOrderSnapshot.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(width: 2.0),
                          Icon(
                            sortOrderSnapshot == ParkingSortOrder.ascending
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ValueListenableBuilder(
            valueListenable: controller.searchParkingNotifier,
            builder: (searchParkingsContext, searchParkingsSnapshot, child) {
              if (searchParkingsSnapshot is SearchParkingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (searchParkingsSnapshot is SearchParkingSuccess) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: searchParkingsSnapshot.parkingList.length,
                  itemBuilder: (context, index) {
                    final parking = searchParkingsSnapshot.parkingList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: ParkingInfoRow(
                        parking: parking,
                        onTap: controller.onSearchResultTap,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                );
              } else if (searchParkingsSnapshot is SearchParkingFailure) {
                return Center(
                  child: Text(
                    'Could not find any parking',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFFA1A1A1),
                        ),
                  ),
                );
              } else if (searchParkingsSnapshot is SearchParkingIsEmpty) {
                return Center(
                  child: Text(
                    'No search results',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFFA1A1A1),
                        ),
                  ),
                );
              }

              return child!;
            },
            child: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
