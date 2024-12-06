import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_favorite_parking_response.g.dart';

@JsonSerializable()
class AddFavoriteParkingResponse with EquatableMixin {
  final String status;
  final String message;

  const AddFavoriteParkingResponse({
    required this.status,
    required this.message,
  });

  factory AddFavoriteParkingResponse.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteParkingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavoriteParkingResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
