import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:equatable/equatable.dart';
import 'package:geobase/geobase.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Parking with EquatableMixin {
  @HiveField(0)
  final String id;
  @JsonKey(name: 'parking_name')
  @HiveField(1)
  final String parkingName;
  @HiveField(2)
  final String address;
  @JsonKey(
    fromJson: _geolocationFromJson,
    toJson: _geolocationToJson,
  )
  @HiveField(3)
  final Point geolocation;
  @JsonKey(name: 'total_slot')
  @HiveField(4)
  final int totalSlot;
  @JsonKey(name: 'available_slot')
  @HiveField(5)
  final int availableSlot;
  @HiveField(6)
  final String? image;
  @HiveField(7)
  final String? phone;
  @JsonKey(name: 'price_per_hour')
  @HiveField(8)
  final List<ShiftPrice>? pricePerHour;
  @JsonKey(name: 'price_per_day')
  @HiveField(9)
  final double? pricePerDay;
  @JsonKey(name: 'price_per_month')
  @HiveField(10)
  final double? pricePerMonth;
  @JsonKey(name: 'price_per_year')
  @HiveField(11)
  final double? pricePerYear;

  Parking({
    required this.id,
    required this.parkingName,
    required this.address,
    required this.geolocation,
    required this.totalSlot,
    required this.availableSlot,
    this.image,
    this.phone,
    this.pricePerHour,
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
        totalSlot,
        availableSlot,
        pricePerHour,
        pricePerDay,
        pricePerMonth,
        pricePerYear,
      ];
}

Point _geolocationFromJson(String geolocation) {
  return Point.decodeHex(geolocation, format: WKB.geometry);
}

String _geolocationToJson(Point geolocation) {
  return geolocation.toBytesHex();
}
