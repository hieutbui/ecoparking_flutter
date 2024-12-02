import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_ticket_Info_state.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/get_ticket_info_interactor.dart';
import 'package:ecoparking_flutter/pages/ticket_details/ticket_details_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketDetails extends StatefulWidget {
  const TicketDetails({super.key});

  @override
  TicketDetailsController createState() => TicketDetailsController();
}

class TicketDetailsController extends State<TicketDetails>
    with ControllerLoggy {
  final BookingService _bookingService = getIt.get<BookingService>();

  final GetTicketInfoInteractor _getTicketInfoInteractor =
      GetTicketInfoInteractor();

  final ValueNotifier<GetTicketInfoState> ticketInfoState =
      ValueNotifier(const GetTicketInfoInitial());

  CreateTicketRequestData? get ticket => _bookingService.createdTicket;

  QrCode get qrCode => QrCode.fromData(
        data: ticket?.id ?? '',
        errorCorrectLevel: QrErrorCorrectLevel.L,
      );

  StreamSubscription? _ticketInfoSubscription;

  @override
  void initState() {
    super.initState();
    _getTicketInfo();
    loggy.info('TicketDetailsController initialized');
  }

  @override
  void dispose() {
    loggy.info('TicketDetailsController disposed');
    _cancelTicketInfoSubscriptions();
    _disposeNotifiers();
    super.dispose();
  }

  void _cancelTicketInfoSubscriptions() {
    _ticketInfoSubscription?.cancel();
  }

  void _disposeNotifiers() {
    ticketInfoState.dispose();
  }

  void _getTicketInfo() {
    _ticketInfoSubscription = _getTicketInfoInteractor
        .execute(_bookingService.createdTicket?.id ?? '')
        .listen((result) => result.fold(
              _handleGetTicketInfoFailure,
              _handleGetTicketInfoSuccess,
            ));
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    NavigationUtils.navigateTo(
      context: scaffoldContext,
      path: AppPaths.reviewSummary,
    );
  }

  void onNavigateToParking() {}

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm, dd/MM/yyyy');

    return formatter.format(dateTime);
  }

  void _handleGetTicketInfoFailure(Failure failure) {
    if (failure is GetTicketInfoEmpty) {
      ticketInfoState.value = const GetTicketInfoEmpty();
    } else if (failure is GetTicketInfoFailure) {
      ticketInfoState.value = failure;
    } else {
      ticketInfoState.value =
          const GetTicketInfoFailure(exception: 'Unknown error');
    }
  }

  void _handleGetTicketInfoSuccess(Success success) {
    if (success is GetTicketInfoLoading) {
      ticketInfoState.value = success;
    } else if (success is GetTicketInfoSuccess) {
      ticketInfoState.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => TicketDetailsView(controller: this);
}
