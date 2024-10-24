import 'package:ecoparking_flutter/pages/review_summary/review_summary.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/info_line/info_table.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    InfoTable(listInfo: controller.ticketInfo),
                    const SizedBox(height: 24),
                    InfoTable(listInfo: controller.feeInfo),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: ActionButton(
              type: ActionButtonType.positive,
              label: 'Continue',
              onPressed: controller.onPressedContinue,
            ),
          ),
        ],
      ),
    );
  }
}
