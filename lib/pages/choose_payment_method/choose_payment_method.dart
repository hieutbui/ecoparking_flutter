import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/model/payment/e_wallet.dart';
import 'package:ecoparking_flutter/pages/choose_payment_method/choose_payment_method_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod({super.key});

  @override
  ChoosePaymentMethodController createState() =>
      ChoosePaymentMethodController();
}

class ChoosePaymentMethodController extends State<ChoosePaymentMethod>
    with ControllerLoggy {
  final BookingService bookingService = getIt.get<BookingService>();

  final List<EWallet> paymentMethods = [EWallet.vnpay];

  final selectedPaymentMethod = ValueNotifier<EWallet?>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selectedPaymentMethod.value = null;
    selectedPaymentMethod.dispose();
    super.dispose();
  }

  void selectPaymentMethod(EWallet paymentMethod) {
    selectedPaymentMethod.value = paymentMethod;
    bookingService.setPaymentMethod(paymentMethod);
  }

  void onPressedContinue() {
    loggy.info('Select Payment Method tapped');

    NavigationUtils.goBack(context);
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.reviewSummary,
    );
  }

  @override
  Widget build(BuildContext context) =>
      ChoosePaymentMethodView(controller: this);
}
