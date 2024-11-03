import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_parkings.g.dart';

@JsonSerializable()
class FavoriteParkings with EquatableMixin {
  final String image;
  @JsonKey(name: 'parking_name')
  final String parkingName;
  final String address;

  FavoriteParkings({
    required this.image,
    required this.parkingName,
    required this.address,
  });

  @override
  List<Object?> get props => [
        image,
        parkingName,
        address,
      ];
}
