import 'package:ecoparking_flutter/pages/book_parking_details/book_parking_details.dart';
import 'package:flutter/material.dart';

class BookParkingDetailsView extends StatelessWidget {
  final BookParkingDetailsController controller;

  const BookParkingDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Parking Details',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.black,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text('Book Parking Details'),
      ),
    );
  }
}
