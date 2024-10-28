import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
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
      title: 'Book Parking Details',
      body: Scaffold(
        appBar: GFAppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: GFSegmentTabs(
            width: MediaQuery.of(context).size.width - 150,
            length: controller.tabLength,
            tabBarColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            indicatorWeight: 5,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            tabs: const <Widget>[
              Text('Hourly'),
              Text('Daily'),
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
