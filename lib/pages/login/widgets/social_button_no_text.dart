import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButtonNoText extends StatelessWidget {
  final String icon;
  final void Function() onPressed;

  const SocialButtonNoText({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: SvgPicture.asset(
          icon,
          width: 24.0,
          height: 24.0,
        ),
      ),
    );
  }
}
