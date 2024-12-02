import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_meta_data.dart';
import 'package:ecoparking_flutter/data/models/payment/create_payment_intent_request_body.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/state/payment/confirm_payment_intent_web_state.dart';
import 'package:ecoparking_flutter/domain/state/payment/create_payment_intent_state.dart';
import 'package:ecoparking_flutter/domain/state/tickets/create_ticket_state.dart';
import 'package:ecoparking_flutter/domain/usecase/payment/confirm_payment_intent_web_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/payment/create_payment_intent_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/create_ticket_interactor.dart';
import 'package:ecoparking_flutter/model/payment/e_wallet.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/calculated_fee.dart';
import 'package:ecoparking_flutter/pages/review_summary/review_summary_view.dart';
import 'package:ecoparking_flutter/pages/review_summary/widgets/checkout_web.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:ecoparking_flutter/widgets/info_line/info_line_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary({super.key});

  @override
  ReviewSummaryController createState() => ReviewSummaryController();
}

class ReviewSummaryController extends State<ReviewSummary>
    with ControllerLoggy {
  final BookingService bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final CreatePaymentIntentInteractor _createPaymentIntentInteractor =
      getIt.get<CreatePaymentIntentInteractor>();
  final ConfirmPaymentIntentWebInteractor _confirmPaymentIntentWebInitial =
      getIt.get<ConfirmPaymentIntentWebInteractor>();
  final CreateTicketInteractor _createTicketInteractor =
      getIt.get<CreateTicketInteractor>();

  final ValueNotifier<EWallet?> paymentMethod = ValueNotifier<EWallet?>(null);
  final ValueNotifier<CreatePaymentIntentState> createPaymentIntentState =
      ValueNotifier<CreatePaymentIntentState>(
    const CreatePaymentIntentInitial(),
  );
  final ValueNotifier<ConfirmPaymentIntentWebState>
      confirmPaymentIntentWebState =
      ValueNotifier<ConfirmPaymentIntentWebState>(
    const ConfirmPaymentIntentWebInitial(),
  );
  final ValueNotifier<CreateTicketState> createTicketState =
      ValueNotifier<CreateTicketState>(
    const CreateTicketInitial(),
  );

  List<InfoLineArguments> ticketInfo = [];
  List<InfoLineArguments> feeInfo = [];

  StreamSubscription? _createPaymentIntentSubscription;
  StreamSubscription? _confirmPaymentIntentWebSubscription;
  StreamSubscription? _createTicketSubscription;

  @override
  void initState() {
    super.initState();
    _initializeInfoTable();
    paymentMethod.value = bookingService.paymentMethod;
    _paymentMethodListener();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelSubscriptions();
    _disposeNotifiers();
    bookingService.removePaymentMethodListener(_paymentMethodListener);
  }

  void _initializeInfoTable() {
    _initializeTicketInfo();
    _initializeFeeInfo();
  }

  void _initializeTicketInfo() {
    final duration = bookingService.calculatedPrice?.calculatedFee is DailyFee
        ? '${(bookingService.calculatedPrice?.calculatedFee as DailyFee).days} days ${bookingService.calculatedPrice?.calculatedFee.hours} hours'
        : '${bookingService.calculatedPrice?.calculatedFee.hours} hours';

    ticketInfo = [
      InfoLineArguments(
        title: 'Parking Name',
        info: bookingService.parking?.parkingName ?? '',
      ),
      InfoLineArguments(
        title: 'Parking Address',
        info: bookingService.parking?.address ?? '',
      ),
      InfoLineArguments(
        title: 'Vehicle',
        info:
            '${bookingService.vehicle?.name} (${bookingService.vehicle?.licensePlate})',
      ),
      InfoLineArguments(
        title: 'Start Date',
        info: _formatDateTime(bookingService.startDateTime),
      ),
      InfoLineArguments(
        title: 'End Date',
        info: _formatDateTime(bookingService.endDateTime),
      ),
      InfoLineArguments(
        title: 'Duration',
        info: duration,
      )
    ];
  }

  void _initializeFeeInfo() {
    feeInfo = [
      InfoLineArguments(
        title: 'Total Fee',
        info: bookingService.calculatedPrice?.calculatedFee.total.toString() ??
            '',
      ),
    ];
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final DateFormat formatter = DateFormat('HH:mm, dd/MM/yyyy');

    return formatter.format(dateTime);
  }

  void _cancelSubscriptions() {
    _createPaymentIntentSubscription?.cancel();
    _confirmPaymentIntentWebSubscription?.cancel();
    _createTicketSubscription?.cancel();
  }

  void _disposeNotifiers() {
    paymentMethod.dispose();
    createPaymentIntentState.dispose();
    confirmPaymentIntentWebState.dispose();
    createTicketState.dispose();
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

    final createPaymentIntentBody = CreatePaymentIntentRequestBody(
      amount:
          bookingService.calculatedPrice?.calculatedFee.total.toString() ?? '0',
      currency: 'vnd',
      description: bookingService.parking?.parkingName != null
          ? 'Book Ticket for Parking: ${bookingService.parking?.parkingName}'
          : 'Book Ticket',
      metadata: CreatePaymentIntentMetaData(
        parkingName: bookingService.parking?.parkingName ?? '',
        parkingAddress: bookingService.parking?.address ?? '',
        vehicle:
            '${bookingService.vehicle?.name} (${bookingService.vehicle?.licensePlate})',
        startDateTime: bookingService.startDateTime?.toIso8601String() ?? '',
        endDateTime: bookingService.endDateTime?.toIso8601String() ?? '',
        hours: bookingService.calculatedPrice?.calculatedFee.hours.toString() ??
            '',
        days: bookingService.calculatedPrice?.calculatedFee is DailyFee
            ? (bookingService.calculatedPrice?.calculatedFee as DailyFee)
                .days
                .toString()
            : '',
      ),
    );

    _createPaymentIntentSubscription =
        _createPaymentIntentInteractor.execute(createPaymentIntentBody).listen(
              (result) => result.fold(
                _handleCreatePaymentIntentFailure,
                _handleCreatePaymentIntentSuccess,
              ),
            );
  }

  void _confirmPaymentWeb() {
    _confirmPaymentIntentWebSubscription =
        _confirmPaymentIntentWebInitial.execute().listen(
              (result) => result.fold(
                _handleConfirmPaymentIntentWebFailure,
                _handleConfirmPaymentIntentWebSuccess,
              ),
            );
  }

  void _handleCreatePaymentIntentFailure(Failure failure) {
    loggy.error('Create Payment Intent failure: $failure');
    if (failure is CreatePaymentIntentEmpty) {
      createPaymentIntentState.value = failure;
    } else if (failure is CreatePaymentIntentStripeError) {
      createPaymentIntentState.value = failure;
    } else if (failure is CreatePaymentIntentStripeException) {
      createPaymentIntentState.value = failure;
    } else {
      createPaymentIntentState.value =
          CreatePaymentIntentFailure(exception: failure);
    }
  }

  void _handleCreatePaymentIntentSuccess(Success success) async {
    loggy.info('Create Payment Intent success: $success');
    if (success is CreatePaymentIntentSuccess) {
      createPaymentIntentState.value = success;

      if (PlatformInfos.isWeb) {
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) => Dialog.fullscreen(
              child: AppScaffold(
                title: 'Payment',
                onBackButtonPressed: (scaffoldContext) {
                  NavigationUtils.goBack(context);
                },
                body: CheckoutWeb(
                  clientSecret: success.paymentIntent.clientSecret,
                  onCardChanged: (cardFieldInputDetails) {
                    loggy.info('Card changed: $cardFieldInputDetails');
                  },
                  onPressedPayment: () async {
                    loggy.info('Payment button pressed');
                    _confirmPaymentWeb();
                  },
                ),
              ),
            ),
          );
        }
      } else {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: success.paymentIntent.clientSecret,
            customFlow: false,
            merchantDisplayName: 'EcoParking',
            style: ThemeMode.system,
          ),
        );
      }
    }
  }

  void _handleConfirmPaymentIntentWebFailure(Failure failure) {
    loggy.error('Confirm Payment Intent Web failure: $failure');
    if (failure is ConfirmPaymentIntentWebStripeError) {
      confirmPaymentIntentWebState.value = failure;
    } else if (failure is ConfirmPaymentIntentWebStripeException) {
      confirmPaymentIntentWebState.value = failure;
    } else {
      confirmPaymentIntentWebState.value =
          ConfirmPaymentIntentWebFailure(exception: failure);
    }
  }

  void _handleConfirmPaymentIntentWebSuccess(Success success) {
    loggy.info('Confirm Payment Intent Web success: $success');
    if (success is ConfirmPaymentIntentWebSuccess) {
      confirmPaymentIntentWebState.value = success;
      NavigationUtils.goBack(context);
      if (success.paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        _createTicketSubscription = _createTicketInteractor
            .execute(bookingService.createTicket(
              paymentIntentId: success.paymentIntent.id,
              userId: _accountService.profile?.id,
            ))
            .listen(
              (result) => result.fold(
                _handleCreateTicketFailure,
                _handleCreateTicketSuccess,
              ),
            );
      }
    } else if (success is ConfirmPaymentIntentWebLoading) {
      confirmPaymentIntentWebState.value = success;
    }
  }

  void _handleCreateTicketFailure(Failure failure) {
    loggy.error('Create Ticket failure: $failure');
    if (failure is CreateTicketEmpty) {
      createTicketState.value = failure;
    } else if (failure is CreateTicketFailure) {
      createTicketState.value = failure;
    } else {
      createTicketState.value = CreateTicketFailure(exception: failure);
    }
  }

  void _handleCreateTicketSuccess(Success success) {
    loggy.info('Create Ticket success: $success');
    if (success is CreateTicketSuccess) {
      bookingService.setCreatedTicket(success.ticket);
      createTicketState.value = success;
      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.ticketDetails,
      );
    } else if (success is CreateTicketLoading) {
      createTicketState.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => ReviewSummaryView(controller: this);
}
