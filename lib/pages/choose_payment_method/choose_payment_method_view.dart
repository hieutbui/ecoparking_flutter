import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method.dart';
import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method_styles.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/selection_card/selection_card.dart';
import 'package:flutter/material.dart';

class ChoosePaymentMethodView extends StatelessWidget {
  final ChoosePaymentMethodController controller;

  const ChoosePaymentMethodView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.paymentMethod.getTitle(),
      onBackButtonPressed: controller.onBackButtonPressed,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: ChoosePaymentMethodStyles.padding,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.paymentMethods.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.paymentMethods.length) {
                      return ActionButton(
                        type: ActionButtonType.positive,
                        label: 'Add New Payment Method',
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        labelColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {},
                      );
                    }

                    final paymentMethod = controller.paymentMethods[index];

                    return ValueListenableBuilder(
                      valueListenable: controller.selectedPaymentMethod,
                      builder: (context, selectedPaymentMethod, child) {
                        return SelectionCard(
                          title: paymentMethod.getName(),
                          trailingImage: paymentMethod.getImagePath(),
                          trailingIcon: paymentMethod.getIcon(),
                          isShowSelectCircle: true,
                          titleColor: Theme.of(context).colorScheme.onSurface,
                          subtitleColor: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5),
                          isSelected: selectedPaymentMethod == paymentMethod,
                          onTap: () =>
                              controller.selectPaymentMethod(paymentMethod),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: ChoosePaymentMethodStyles.listSeparatorHeight,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: ChoosePaymentMethodStyles.bottomContainerPadding,
            decoration: ChoosePaymentMethodStyles.bottomContainerDecoration,
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
