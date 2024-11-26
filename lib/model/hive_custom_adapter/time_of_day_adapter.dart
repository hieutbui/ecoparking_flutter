import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final int typeId = 5;

  @override
  TimeOfDay read(BinaryReader reader) {
    final int hour = reader.readInt();
    final int minute = reader.readInt();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer
      ..writeInt(obj.hour)
      ..writeInt(obj.minute);
  }
}
