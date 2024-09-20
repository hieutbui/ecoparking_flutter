import 'package:ecoparking_flutter/pages/review_summary/review_summary_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary({super.key});

  @override
  ReviewSummaryController createState() => ReviewSummaryController();
}

class ReviewSummaryController extends State<ReviewSummary>
    with ControllerLoggy {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedReviewSummary() {
    loggy.info('Review Summary tapped');

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
