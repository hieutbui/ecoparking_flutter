import 'package:ecoparking_flutter/pages/booking/booking.dart';
import 'package:flutter/material.dart';

class BookingPageView extends StatelessWidget {
  final BookingController controller;

  const BookingPageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Booking Screen');
  }
}
