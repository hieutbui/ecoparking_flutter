import 'package:dio/dio.dart';
import 'package:ecoparking_flutter/config/env_loader.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_response.dart';
import 'package:ecoparking_flutter/data/network/dio_client.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/global/network_di.dart';

class StripePaymentApi {
  final DioClient _dioClient = getIt.get<DioClient>(
    instanceName: NetworkDi.serverDioClientName,
  );

  StripePaymentApi();

  Future<CreatePaymentIntentResponse> createPaymentIntent(
    CreatePaymentIntentRequestBody body,
  ) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final secretKey = EnvLoader.stripeSecretKey;
    final requestBody = {
      "amount": body.amount,
      "currency": body.currency,
      "description": body.description,
      "metadata": {
        "parking_name": body.metadata.parkingName,
        "parking_address": body.metadata.parkingAddress,
        "vehicle": body.metadata.vehicle,
        "start_date_time": body.metadata.startDateTime,
        "end_date_time": body.metadata.endDateTime,
        "hours": body.metadata.hours,
        "days": body.metadata.days,
      }
    };

    final response = await _dioClient
        .post(
          url.toString(),
          data: requestBody,
          options: Options(
            headers: {
              "Authorization": "Bearer $secretKey",
              'Content-Type': 'application/x-www-form-urlencoded'
            },
          ),
        )
        .onError((error, stackTrace) => throw Exception(error));

    return CreatePaymentIntentResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
