import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_parking.g.dart';

@JsonSerializable()
class FavoriteParking with EquatableMixin {
  final String id;
  final String image;
  @JsonKey(name: 'parking_name')
  final String parkingName;
  final String address;

  factory FavoriteParking.fromJson(Map<String, dynamic> json) =>
      _$FavoriteParkingFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteParkingToJson(this);

  const FavoriteParking({
    required this.id,
    required this.image,
    required this.parkingName,
    required this.address,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        parkingName,
        address,
      ];
}
