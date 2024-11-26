import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift_price.g.dart';

enum ShiftType {
  @JsonValue('morning')
  morning,
  @JsonValue('afternoon')
  afternoon,
  @JsonValue('night')
  night,
  @JsonValue('other')
  other,
}

TimeOfDay _timeOfDayFromString(String time) {
  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

String _timeOfDayToString(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

@JsonSerializable()
@HiveType(typeId: 2)
class ShiftPrice with EquatableMixin {
  @JsonKey(name: 'shift_type')
  @HiveField(0)
  final ShiftType shiftType;
  @JsonKey(
    name: 'start_time',
    fromJson: _timeOfDayFromString,
    toJson: _timeOfDayToString,
  )
  @HiveField(1)
  final TimeOfDay startTime;
  @JsonKey(
    name: 'end_time',
    fromJson: _timeOfDayFromString,
    toJson: _timeOfDayToString,
  )
  @HiveField(2)
  final TimeOfDay endTime;
  @HiveField(3)
  final double price;

  ShiftPrice({
    required this.shiftType,
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  factory ShiftPrice.fromJson(Map<String, dynamic> json) =>
      _$ShiftPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftPriceToJson(this);

  @override
  List<Object?> get props => [
        shiftType,
        startTime,
        endTime,
        price,
      ];
}
