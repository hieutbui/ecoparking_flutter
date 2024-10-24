import 'package:ecoparking_flutter/widgets/info_line/info_line.dart';
import 'package:ecoparking_flutter/widgets/info_line/info_line_arguments.dart';
import 'package:flutter/material.dart';

class InfoTable extends StatelessWidget {
  final List<InfoLineArguments> listInfo;

  const InfoTable({
    super.key,
    required this.listInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(23)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: listInfo.length,
        itemBuilder: (context, index) {
          return InfoLine(
            arguments: listInfo[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 6,
        ),
      ),
    );
  }
}
