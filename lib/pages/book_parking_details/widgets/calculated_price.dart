import 'package:ecoparking_flutter/pages/book_parking_details/model/calculated_fee.dart';
import 'package:flutter/material.dart';

class CalculatedPrice extends StatelessWidget {
  final ValueNotifier<CalculatedFee?> calculatedPrice;

  const CalculatedPrice({
    super.key,
    required this.calculatedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: calculatedPrice,
      builder: (BuildContext context, CalculatedFee? value, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <InlineSpan>[
                  //TODO: Format the total price
                  TextSpan(
                    text: value?.total.toString() ?? '0',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  TextSpan(
                    text: ' / ',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFA1A1A1),
                        ),
                  ),
                  if (value is DailyFee) ...[
                    TextSpan(
                      text: '${value.days} days + ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA1A1A1),
                          ),
                    ),
                  ],
                  TextSpan(
                    text: '${value != null ? value.hours : 0} hours',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFA1A1A1),
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
