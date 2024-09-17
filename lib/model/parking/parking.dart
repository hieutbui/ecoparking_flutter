import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking.g.dart';

@JsonSerializable()
class Parking with EquatableMixin {
  final String id;
  @JsonKey(name: 'parking_name')
  final String parkingName;
  final String image;
  final String address;
  final double latitude;
  final double longitude;
  @JsonKey(name: 'total_slot')
  final int totalSlot;
  @JsonKey(name: 'available_slot')
  final int availableSlot;
  @JsonKey(name: 'price_per_hour')
  final List<ShiftPrice> pricePerHour;
  @JsonKey(name: 'price_per_day')
  final double? pricePerDay;
  @JsonKey(name: 'price_per_month')
  final double? pricePerMonth;
  @JsonKey(name: 'price_per_year')
  final double? pricePerYear;

  Parking({
    required this.id,
    required this.parkingName,
    required this.image,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSlot,
    required this.availableSlot,
    required this.pricePerHour,
    this.pricePerDay,
    this.pricePerMonth,
    this.pricePerYear,
  });

  factory Parking.fromJson(Map<String, dynamic> json) =>
      _$ParkingFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingToJson(this);

  @override
  List<Object?> get props => [
        id,
        parkingName,
        image,
        address,
        latitude,
        longitude,
        totalSlot,
        availableSlot,
        pricePerHour,
        pricePerDay,
        pricePerMonth,
        pricePerYear,
      ];
}
