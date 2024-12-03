import 'package:ecoparking_flutter/data/datasource/payment/payment_datasource.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:ecoparking_flutter/data/supabase_data/database_functions_name.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/utils/conditional_import/stripe/confirm_payment/confirm_payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentDataSourceImpl extends PaymentDataSource {
  @override
  Future<Map<String, dynamic>?> createPaymentIntent(
    CreatePaymentIntentRequestBody body,
  ) {
    return SupabaseUtils().client.rpc(
      DatabaseFunctionsName.createPaymentIntent.functionName,
      params: {
        'amount': body.amount,
        'currency': body.currency,
        'description': body.description,
        'parking_name': body.metadata.parkingName,
        'parking_address': body.metadata.parkingAddress,
        'vehicle': body.metadata.vehicle,
        'start_date_time': body.metadata.startDateTime,
        'end_date_time': body.metadata.endDateTime,
        'hours': body.metadata.hours,
        'days': body.metadata.days,
      },
    );
  }

  @override
  Future<PaymentIntent?> confirmPaymentIntentWeb() {
    return StripeConfirmPayment.confirmPayment();
  }
}
