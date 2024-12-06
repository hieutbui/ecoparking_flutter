import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remove_favorite_parking_response.g.dart';

@JsonSerializable()
class RemoveFavoriteParkingResponse with EquatableMixin {
  final String status;
  final String message;

  const RemoveFavoriteParkingResponse({
    required this.status,
    required this.message,
  });

  factory RemoveFavoriteParkingResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveFavoriteParkingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveFavoriteParkingResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
