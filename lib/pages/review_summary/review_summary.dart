import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/model/payment/e_wallet.dart';
import 'package:ecoparking_flutter/pages/review_summary/review_summary_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/info_line/info_line_arguments.dart';
import 'package:flutter/material.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary({super.key});

  @override
  ReviewSummaryController createState() => ReviewSummaryController();
}

class ReviewSummaryController extends State<ReviewSummary>
    with ControllerLoggy {
  final BookingService bookingService = getIt.get<BookingService>();

  final ValueNotifier<EWallet?> paymentMethod = ValueNotifier<EWallet?>(null);

  final List<InfoLineArguments> ticketInfo = [
    const InfoLineArguments(
      title: 'Parking Area',
      info: 'Parking Lot of Son Manolia',
    ),
    const InfoLineArguments(
      title: 'Address',
      info: '9569, trantow Courts',
    ),
    const InfoLineArguments(
      title: 'Vehicle',
      info: 'Toyota Land Cru (AFD 6397)',
    ),
    const InfoLineArguments(
      title: 'Parking Spot',
      info: '1st Floor (A05)',
    ),
    const InfoLineArguments(
      title: 'Date',
      info: 'May 11, 2023',
    ),
    const InfoLineArguments(
      title: 'Duration',
      info: '4 hours',
    ),
    const InfoLineArguments(
      title: 'Hours',
      info: '09:00 AM - 13:00 PM',
    ),
  ];

  final List<InfoLineArguments> feeInfo = [
    const InfoLineArguments(
      title: 'Parking Fee',
      info: 'VND 20,000',
    ),
    const InfoLineArguments(
      title: 'Service Fee',
      info: 'VND 5,000',
      isShowDivider: true,
    ),
    const InfoLineArguments(
      title: 'Total',
      info: 'VND 25,000',
    ),
  ];

  @override
  void initState() {
    super.initState();
    paymentMethod.value = bookingService.paymentMethod;

    _paymentMethodListener();
  }

  @override
  void dispose() {
    super.dispose();

    bookingService.removePaymentMethodListener(_paymentMethodListener);
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('Back button pressed');
    NavigationUtils.navigateTo(
      context: scaffoldContext,
      path: AppPaths.selectVehicle,
    );
  }

  void _paymentMethodListener() {
    bookingService.addPaymentMethodListener(
      () => paymentMethod.value = bookingService.paymentMethod,
    );
  }

  void onPressSelectPaymentMethod() {
    loggy.info('Select Payment Method tapped');

    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.paymentMethod,
    );

    return;
  }

  void onPressedContinue() {
    loggy.info('Continue tapped');
  }

  @override
  Widget build(BuildContext context) => ReviewSummaryView(controller: this);
}
