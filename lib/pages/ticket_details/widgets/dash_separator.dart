import 'package:flutter/material.dart';

class DashSeparator extends StatelessWidget {
  const DashSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double boxWidth = constraints.constrainWidth();
        const double dashWidth = 5.0;
        const double dashHeight = 1.0;
        final int dashCount = (boxWidth / (1.5 * dashWidth)).floor();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List<Widget>.generate(
              dashCount,
              (_) {
                return const SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xFFCACACA)),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
