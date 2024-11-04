import 'package:ecoparking_flutter/pages/profile/model/setting_button_arguments.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SettingButton extends StatelessWidget {
  final SettingButtonArguments arguments;

  const SettingButton({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: arguments.leftIcon != null
          ? Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: Icon(
                arguments.leftIcon,
                size: 24.0,
                color: arguments.isDanger == true
                    ? const Color(0xFFDE1800)
                    : const Color(0xFFA1A1A1),
              ),
            )
          : null,
      title: Text(
        arguments.title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: arguments.isDanger == true
                  ? const Color(0xFFDE1800)
                  : arguments.titleColor ?? Colors.black,
            ),
      ),
      icon: arguments.rightWidget,
      shadow: const BoxShadow(color: Colors.transparent),
      onTap: arguments.onTap,
    );
  }
}
