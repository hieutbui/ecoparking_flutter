import 'package:ecoparking_flutter/pages/booking/booking_view.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  BookingController createState() => BookingController();
}

class BookingController extends State<BookingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BookingPageView(controller: this);
}
