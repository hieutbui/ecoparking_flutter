import 'package:ecoparking_flutter/pages/review_summary/review_summary_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/widgets/info_line/info_line_arguments.dart';
import 'package:flutter/material.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary({super.key});

  @override
  ReviewSummaryController createState() => ReviewSummaryController();
}

class ReviewSummaryController extends State<ReviewSummary>
    with ControllerLoggy {
  final List<InfoLineArguments> ticketInfo = [
    const InfoLineArguments(
      title: 'Parking Area',
      info: 'Parking Lot of Son Manolia',
    ),
    const InfoLineArguments(
      title: 'Address',
      info: '9569, trantow Courts',
    ),
    const InfoLineArguments(
      title: 'Vehicle',
      info: 'Toyota Land Cru (AFD 6397)',
    ),
    const InfoLineArguments(
      title: 'Parking Spot',
      info: '1st Floor (A05)',
    ),
    const InfoLineArguments(
      title: 'Date',
      info: 'May 11, 2023',
    ),
    const InfoLineArguments(
      title: 'Duration',
      info: '4 hours',
    ),
    const InfoLineArguments(
      title: 'Hours',
      info: '09:00 AM - 13:00 PM',
    ),
  ];

  final List<InfoLineArguments> feeInfo = [
    const InfoLineArguments(
      title: 'Parking Fee',
      info: 'VND 20,000',
    ),
    const InfoLineArguments(
      title: 'Service Fee',
      info: 'VND 5,000',
      isShowDivider: true,
    ),
    const InfoLineArguments(
      title: 'Total',
      info: 'VND 25,000',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedContinue() {
    loggy.info('Continue tapped');

    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog.fullscreen(
        child: Placeholder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ReviewSummaryView(controller: this);
}
