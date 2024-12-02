import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_meta_data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_intent_request_body.g.dart';

@JsonSerializable()
class CreatePaymentIntentRequestBody with EquatableMixin {
  final String amount;
  final String currency;
  final String description;
  final CreatePaymentIntentMetaData metadata;

  const CreatePaymentIntentRequestBody({
    required this.amount,
    required this.currency,
    required this.description,
    required this.metadata,
  });

  factory CreatePaymentIntentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentIntentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentIntentRequestBodyToJson(this);

  @override
  List<Object?> get props => [
        amount,
        currency,
        description,
        metadata,
      ];
}
