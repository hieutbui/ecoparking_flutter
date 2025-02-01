import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details_view_styles.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/daily_view.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/widgets/hourly_view.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/tabs/gf_segment_tabs.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';

class BookParkingDetailsView extends StatelessWidget {
  final BookParkingDetailsController controller;

  const BookParkingDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.bookingDetails.getTitle(),
      onBackButtonPressed: controller.onBackButtonPressed,
      body: Scaffold(
        appBar: GFAppBar(
          bottomOpacity: BookParkingDetailsViewStyles.bottomOpacity,
          elevation: BookParkingDetailsViewStyles.elevation,
          backgroundColor: Colors.white,
          title: GFSegmentTabs(
            width: BookParkingDetailsViewStyles.segmentTabsWidth(context),
            length: controller.tabLength,
            tabBarColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            border: BookParkingDetailsViewStyles.segmentTabsBorder(context),
            indicatorPadding: EdgeInsets.zero,
            borderRadius: BookParkingDetailsViewStyles.segmentTabsBorderRadius,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator:
                BookParkingDetailsViewStyles.segmentTabsIndicator(context),
            tabs: const <Widget>[
              Tab(child: Text('Theo giờ')),
              Tab(child: Text('Theo ngày')),
            ],
            tabController: controller.tabController,
            labelPadding: EdgeInsets.zero,
          ),
        ),
        body: GFTabBarView(
          controller: controller.tabController,
          children: <Widget>[
            HourlyView(controller: controller),
            DailyView(controller: controller),
          ],
        ),
      ),
    );
  }
}
