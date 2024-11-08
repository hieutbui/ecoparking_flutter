import 'package:ecoparking_flutter/pages/review_summary/review_summary.dart';
import 'package:ecoparking_flutter/pages/review_summary/summary_view_styles.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/info_line/info_table.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

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
      onBackButtonPressed: controller.onBackButtonPressed,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: SummaryViewStyles.scrollViewPadding,
                child: Column(
                  children: <Widget>[
                    InfoTable(listInfo: controller.ticketInfo),
                    const SizedBox(height: SummaryViewStyles.infoTablesSpacing),
                    InfoTable(listInfo: controller.feeInfo),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: SummaryViewStyles.bottomContainerPadding,
            decoration: SummaryViewStyles.bottomContainerDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ValueListenableBuilder(
                  valueListenable: controller.paymentMethod,
                  builder: (context, paymentMethod, child) {
                    return GFListTile(
                      titleText: paymentMethod != null
                          ? paymentMethod.getName()
                          : 'Please select payment method',
                      subTitleText: paymentMethod != null
                          ? null
                          : 'Choose how you want to pay',
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      avatar: paymentMethod != null
                          ? Image.asset(
                              paymentMethod.getImagePath(),
                              width: 46,
                              height: 46,
                            )
                          : const Icon(Icons.payment),
                      onTap: controller.onPressSelectPaymentMethod,
                    );
                  },
                ),
                const SizedBox(height: SummaryViewStyles.actionButtonsSpacing),
                ActionButton(
                  type: ActionButtonType.positive,
                  label: 'Continue',
                  onPressed: controller.onPressedContinue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
