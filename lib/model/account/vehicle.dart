import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle with EquatableMixin {
  final String id;
  final String name;
  @JsonKey(name: 'license_plate')
  final String licensePlate;

  Vehicle({
    required this.id,
    required this.name,
    required this.licensePlate,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        licensePlate,
      ];
}
