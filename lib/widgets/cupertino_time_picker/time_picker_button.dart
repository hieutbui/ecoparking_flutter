import 'package:flutter/material.dart';

class TimePickerButton extends StatelessWidget {
  final String title;
  final TimeOfDay selectedTime;
  final void Function() onPressed;

  const TimePickerButton({
    super.key,
    required this.title,
    required this.selectedTime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(height: 16.0),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 34.0,
                right: 18.0,
              ),
              decoration: const BoxDecoration(
                color: Color(0xF0F0F0F0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(width: 28.0),
                  const Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
