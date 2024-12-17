import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qr_data.g.dart';

@JsonSerializable()
class QrData with EquatableMixin {
  @JsonKey(name: 'ticket_id')
  final String ticketId;
  final int timestamp;

  QrData({
    required this.ticketId,
    required this.timestamp,
  });

  factory QrData.fromJson(Map<String, dynamic> json) => _$QrDataFromJson(json);

  Map<String, dynamic> toJson() => _$QrDataToJson(this);

  @override
  List<Object?> get props => [ticketId, timestamp];
}
