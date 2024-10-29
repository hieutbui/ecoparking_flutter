import 'package:ecoparking_flutter/pages/my_tickets/my_tickets.dart';
import 'package:flutter/material.dart';

class CancelledView extends StatelessWidget {
  final MyTicketsController controller;

  const CancelledView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cancelled View'),
    );
  }
}
