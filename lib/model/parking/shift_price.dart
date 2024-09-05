import 'package:equatable/equatable.dart';
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

@JsonSerializable()
class ShiftPrice with EquatableMixin {
  final String id;
  @JsonKey(name: 'shift_type')
  final ShiftType shiftType;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  final double price;

  ShiftPrice({
    required this.id,
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
        id,
        shiftType,
        startTime,
        endTime,
        price,
      ];
}
