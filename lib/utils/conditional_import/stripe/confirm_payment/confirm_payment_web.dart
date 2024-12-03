import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/mixin_utils.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';

class StripeConfirmPayment {
  static Future<PaymentIntent> confirmPayment() async {
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
