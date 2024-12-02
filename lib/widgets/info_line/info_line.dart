import 'package:ecoparking_flutter/widgets/info_line/info_line_arguments.dart';
import 'package:ecoparking_flutter/widgets/info_line/info_line_styles.dart';
import 'package:flutter/material.dart';

class InfoLine extends StatelessWidget {
  final InfoLineArguments arguments;

  const InfoLine({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration:
          arguments.isShowDivider ? InfoLineStyles.containerDecoration : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            arguments.title,
            style: InfoLineStyles.titleStyle(context),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              arguments.info,
              style: InfoLineStyles.infoStyle(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
