import 'package:ecoparking_flutter/model/ticket/ticket_status.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket with EquatableMixin {
  final String id;
  @JsonKey(name: 'parking_name')
  final String parkingName;
  @JsonKey(name: 'parking_address')
  final String parkingAddress;
  @JsonKey(name: 'vehicle_name')
  final String vehicleName;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  final int days;
  final int hours;
  final double total;
  @JsonKey(name: 'status')
  final TicketStatus status;
  @JsonKey(name: 'parking_phone')
  final String? parkingPhone;
  @JsonKey(name: 'parking_image')
  final String? parkingImage;

  Ticket({
    required this.id,
    required this.parkingName,
    required this.parkingAddress,
    required this.vehicleName,
    required this.licensePlate,
    required this.startTime,
    required this.endTime,
    required this.days,
    required this.hours,
    required this.total,
    required this.status,
    this.parkingPhone,
    this.parkingImage,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  List<Object?> get props => [
        id,
        parkingName,
        parkingAddress,
        vehicleName,
        licensePlate,
        startTime,
        endTime,
        days,
        hours,
        total,
        status,
        parkingPhone,
        parkingImage,
      ];
}
