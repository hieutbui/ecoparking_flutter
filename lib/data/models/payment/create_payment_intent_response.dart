import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_meta_data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_intent_response.g.dart';

@JsonSerializable()
class CreatePaymentIntentResponse with EquatableMixin {
  final String id;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  final CreatePaymentIntentMetaData metadata;

  const CreatePaymentIntentResponse({
    required this.id,
    required this.clientSecret,
    required this.metadata,
  });

  factory CreatePaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentIntentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentIntentResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        clientSecret,
        metadata,
      ];
}
