import 'package:ecoparking_flutter/model/ticket/ticket_status.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_ticket_request_data.g.dart';

@JsonSerializable(includeIfNull: false)
class CreateTicketRequestData with EquatableMixin {
  @JsonKey(name: 'parking_id')
  final String parkingId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'vehicle_id')
  final String vehicleId;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;
  final int days;
  final int hours;
  final double total;
  final TicketStatus status;
  final String? id;
  @JsonKey(name: 'payment_intent_id')
  final String? paymentIntentId;

  CreateTicketRequestData({
    required this.parkingId,
    required this.userId,
    required this.vehicleId,
    required this.startTime,
    required this.endTime,
    required this.days,
    required this.hours,
    required this.total,
    required this.status,
    this.id,
    this.paymentIntentId,
  });

  factory CreateTicketRequestData.fromJson(Map<String, dynamic> json) =>
      _$CreateTicketRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTicketRequestDataToJson(this);

  @override
  List<Object?> get props => [
        parkingId,
        userId,
        vehicleId,
        startTime,
        endTime,
        days,
        hours,
        total,
        status,
        id,
        paymentIntentId,
      ];
}
