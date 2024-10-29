import 'package:ecoparking_flutter/pages/my_tickets/my_tickets_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  MyTicketsController createState() => MyTicketsController();
}

class MyTicketsController extends State<MyTicketsPage>
    with ControllerLoggy, TickerProviderStateMixin {
  int get tabLength => 3;

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: tabLength,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MyTicketsView(controller: this);
}
