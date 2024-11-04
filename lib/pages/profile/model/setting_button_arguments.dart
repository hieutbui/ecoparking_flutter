import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingButtonArguments with EquatableMixin {
  final String title;
  final Color? titleColor;
  final IconData? leftIcon;
  final Widget? rightWidget;
  final bool? isDanger;
  final void Function()? onTap;

  const SettingButtonArguments({
    required this.title,
    this.titleColor,
    this.leftIcon,
    this.rightWidget,
    this.isDanger = false,
    this.onTap,
  });

  @override
  List<Object?> get props => [
        title,
        leftIcon,
        rightWidget,
        isDanger,
        onTap,
      ];
}
