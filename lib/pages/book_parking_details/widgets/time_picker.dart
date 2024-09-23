import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final DateTime? initialDateTime;
  final DateTime? minimumDate;

  const TimePicker({
    super.key,
    required this.onDateTimeChanged,
    this.initialDateTime,
    this.minimumDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.only(top: 8.0),
      color: Colors.white,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        minimumDate: minimumDate,
        initialDateTime: initialDateTime,
        onDateTimeChanged: onDateTimeChanged,
        use24hFormat: true,
      ),
    );
  }
}
