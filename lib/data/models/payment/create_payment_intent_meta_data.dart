import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_intent_meta_data.g.dart';

@JsonSerializable()
class CreatePaymentIntentMetaData with EquatableMixin {
  @JsonKey(name: 'parking_name')
  final String parkingName;
  @JsonKey(name: 'parking_address')
  final String parkingAddress;
  final String vehicle;
  @JsonKey(name: 'start_date_time')
  final String startDateTime;
  @JsonKey(name: 'end_date_time')
  final String endDateTime;
  final String hours;
  final String days;

  const CreatePaymentIntentMetaData({
    required this.parkingName,
    required this.parkingAddress,
    required this.vehicle,
    required this.startDateTime,
    required this.endDateTime,
    required this.hours,
    required this.days,
  });

  factory CreatePaymentIntentMetaData.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentIntentMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentIntentMetaDataToJson(this);

  @override
  List<Object?> get props => [
        parkingName,
        parkingAddress,
        vehicle,
        startDateTime,
        endDateTime,
        hours,
        days,
      ];
}
