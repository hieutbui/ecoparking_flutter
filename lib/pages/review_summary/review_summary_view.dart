import 'package:ecoparking_flutter/pages/review_summary/review_summary.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ReviewSummaryView extends StatelessWidget {
  final ReviewSummaryController controller;

  const ReviewSummaryView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Review Summary',
      body: Center(
        child: ActionButton(
          type: ActionButtonType.positive,
          label: 'Open',
          onPressed: controller.onPressedReviewSummary,
        ),
      ),
    );
  }
}
