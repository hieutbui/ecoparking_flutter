import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/my_tickets/model/ticket_pages.dart';
import 'package:ecoparking_flutter/pages/my_tickets/my_tickets.dart';
import 'package:ecoparking_flutter/pages/my_tickets/widgets/list_ticket.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/tabs/gf_segment_tabs.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';

class MyTicketsView extends StatelessWidget {
  final MyTicketsController controller;

  const MyTicketsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.booking.getTitle(),
      body: Scaffold(
        appBar: GFAppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: GFSegmentTabs(
            width: MediaQuery.of(context).size.width,
            length: controller.tabLength,
            tabBarColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            indicatorPadding: EdgeInsets.zero,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            tabs: const <Widget>[
              Tab(child: Text('On Going')),
              Tab(child: Text('Completed')),
              Tab(child: Text('Cancelled')),
            ],
            tabController: controller.tabController,
            labelPadding: EdgeInsets.zero,
          ),
        ),
        body: GFTabBarView(
          controller: controller.tabController,
          children: <Widget>[
            ListTicket(
              ticketsNotifier: controller.onGoingTicketsNotifier,
              page: TicketPages.onGoing,
              onCancelBooking: controller.cancelBooking,
              onViewTicket: controller.viewTicket,
            ),
            ListTicket(
              ticketsNotifier: controller.completedTicketsNotifier,
              page: TicketPages.completed,
              onCancelBooking: controller.cancelBooking,
              onViewTicket: controller.viewTicket,
            ),
            ListTicket(
              ticketsNotifier: controller.cancelledTicketsNotifier,
              page: TicketPages.cancelled,
              onCancelBooking: controller.cancelBooking,
              onViewTicket: controller.viewTicket,
            ),
          ],
        ),
      ),
    );
  }
}
