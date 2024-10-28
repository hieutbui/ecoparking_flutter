import 'package:ecoparking_flutter/pages/my_tickets/my_tickets.dart';
import 'package:flutter/material.dart';

class MyTicketsView extends StatelessWidget {
  final MyTicketsController controller;

  const MyTicketsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('My Tickets Screen');
  }
}
