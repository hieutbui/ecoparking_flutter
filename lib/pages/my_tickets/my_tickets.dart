import 'package:ecoparking_flutter/pages/my_tickets/my_tickets_view.dart';
import 'package:flutter/material.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  MyTicketsController createState() => MyTicketsController();
}

class MyTicketsController extends State<MyTicketsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MyTicketsView(controller: this);
}
