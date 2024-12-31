import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/pages/home/home.dart';
import 'package:ecoparking_flutter/pages/home/widgets/search_parking/parking_info_row.dart';
import 'package:flutter/material.dart';

class RecentSearchList extends StatelessWidget {
  final HomeController controller;
  final void Function(Parking parking) onRecentTap;

  const RecentSearchList({
    super.key,
    required this.controller,
    required this.onRecentTap,
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
            'Tìm kiếm gần đây',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
          ),
        ),
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: FutureBuilder<List<Parking>>(
            future: controller.getRecentSearches(),
            builder: (recentSearchContext, recentSearchSnapshot) {
              if (recentSearchSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (recentSearchSnapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Không thể tải dữ liệu',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFFA1A1A1),
                        ),
                  ),
                );
              } else if (!recentSearchSnapshot.hasData ||
                  recentSearchSnapshot.data == null ||
                  recentSearchSnapshot.data!.isEmpty) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Không có dữ liệu',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFFA1A1A1),
                        ),
                  ),
                );
              } else {
                final recentSearches = recentSearchSnapshot.data!;
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: recentSearches.length,
                  itemBuilder: (context, index) {
                    final parking = recentSearches[index];
                    return ParkingInfoRow(
                      parking: parking,
                      onTap: onRecentTap,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
