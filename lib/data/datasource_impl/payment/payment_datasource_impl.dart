import 'package:ecoparking_flutter/data/datasource/payment/payment_datasource.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_response.dart';
import 'package:ecoparking_flutter/data/network/payment/stripe_payment_api.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/mixin_utils.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';

class PaymentDataSourceImpl extends PaymentDataSource {
  final StripePaymentApi _stripePaymentApi = getIt.get<StripePaymentApi>();

  @override
  Future<CreatePaymentIntentResponse> createPaymentIntent(
      CreatePaymentIntentRequestBody body) {
    return _stripePaymentApi.createPaymentIntent(body);
  }

  @override
  Future<PaymentIntent> confirmPaymentIntentWeb() {
    return WebStripe.instance.confirmPaymentElement(
      ConfirmPaymentElementOptions(
        confirmParams: ConfirmPaymentParams(
          return_url: '${MixinUtils().getRedirectURL()}/payment-return',
        ),
        redirect: PaymentConfirmationRedirect.ifRequired,
      ),
    );
  }
}
