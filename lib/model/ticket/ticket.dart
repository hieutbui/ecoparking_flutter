import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket with EquatableMixin {
  @JsonKey(name: 'parking_name')
  final String parkingName;
  final String image;
  final String address;
  @JsonKey(name: 'phone')
  final String parkingPhone;
  @JsonKey(name: 'vehicle_name')
  final String vehicleName;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;

  Ticket({
    required this.parkingName,
    required this.image,
    required this.address,
    required this.parkingPhone,
    required this.vehicleName,
    required this.licensePlate,
    required this.startTime,
    required this.endTime,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  List<Object?> get props => [
        parkingName,
        image,
        address,
        parkingPhone,
        vehicleName,
        licensePlate,
        startTime,
        endTime,
      ];
}
