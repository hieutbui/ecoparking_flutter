import 'package:ecoparking_flutter/model/ticket/ticket_status.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scanned_ticket_info.g.dart';

@JsonSerializable()
class ScannedTicketInfo with EquatableMixin {
  final String id;
  @JsonKey(name: 'parking_id')
  final String parkingId;
  @JsonKey(name: 'payment_intent_id')
  final String paymentIntentId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'vehicle_id')
  final String vehicleId;
  final TicketStatus status;
  final num total;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  @JsonKey(name: 'entry_time')
  final DateTime? entryTime;
  @JsonKey(name: 'exit_time')
  final DateTime? exitTime;
  final num hours;
  final num days;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const ScannedTicketInfo({
    required this.id,
    required this.parkingId,
    required this.paymentIntentId,
    required this.userId,
    required this.vehicleId,
    required this.status,
    required this.total,
    required this.startTime,
    required this.endTime,
    required this.entryTime,
    required this.exitTime,
    required this.hours,
    required this.days,
    required this.createdAt,
  });

  factory ScannedTicketInfo.fromJson(Map<String, dynamic> json) =>
      _$ScannedTicketInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ScannedTicketInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        parkingId,
        paymentIntentId,
        userId,
        vehicleId,
        status,
        total,
        startTime,
        endTime,
        entryTime,
        exitTime,
        hours,
        days,
        createdAt,
      ];
}
