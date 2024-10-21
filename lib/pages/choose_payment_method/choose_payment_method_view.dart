import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method.dart';
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
      title: 'Payment',
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ListView.separated(
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
                  height: 22,
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
