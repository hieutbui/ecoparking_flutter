import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/state/tickets/cancel_ticket_state.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_user_tickets_state.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/cancel_ticket_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/ticket_interactor.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';
import 'package:ecoparking_flutter/pages/my_tickets/model/ticket_pages.dart';
import 'package:ecoparking_flutter/pages/my_tickets/my_tickets_view.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  MyTicketsController createState() => MyTicketsController();
}

class MyTicketsController extends State<MyTicketsPage>
    with ControllerLoggy, TickerProviderStateMixin {
  final TicketInteractor _ticketInteractor = getIt.get<TicketInteractor>();
  final CancelTicketInteractor _cancelTicketInteractor =
      getIt.get<CancelTicketInteractor>();

  final BookingService _bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final onGoingTicketsNotifier = ValueNotifier<GetUserTicketsState>(
    const GetUserTicketsInitial(),
  );
  final completedTicketsNotifier = ValueNotifier<GetUserTicketsState>(
    const GetUserTicketsInitial(),
  );
  final cancelledTicketsNotifier = ValueNotifier<GetUserTicketsState>(
    const GetUserTicketsInitial(),
  );
  final cancelTicketNotifier = ValueNotifier<CancelTicketState>(
    const CancelTicketInitial(),
  );

  StreamSubscription? _onGoingTicketSubscription;
  StreamSubscription? _completedTicketSubscription;
  StreamSubscription? _cancelledTicketSubscription;
  StreamSubscription? _cancelTicketSubscription;

  TicketPages currentPage = TicketPages.onGoing;

  int get tabLength => TicketPages.values.length;
  int get initialTabIndex => currentPage.pageIndex;

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: initialTabIndex,
      length: tabLength,
      vsync: this,
    );
    tabController.addListener(_onTabIndexChangedListener);

    _getTicketsForPage(currentPage);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.removeListener(_onTabIndexChangedListener);
    _cancelSubscriptions();
    tabController.dispose();
    _disposeNotifiers();
  }

  void _getTicketsForPage(TicketPages page) {
    switch (page) {
      case TicketPages.onGoing:
        _getOnGoingTickets();
        break;
      case TicketPages.completed:
        _getCompletedTickets();
        break;
      case TicketPages.cancelled:
        _getCancelledTickets();
        break;
      default:
        _getOnGoingTickets();
        break;
    }

    return;
  }

  void _getOnGoingTickets() {
    _onGoingTicketSubscription =
        _ticketInteractor.execute(TicketPages.onGoing).listen(
              (result) => result.fold(
                _handleGetOnGoingTicketsFailure,
                _handleGetOnGoingTicketsSuccess,
              ),
            );

    return;
  }

  void _getCompletedTickets() {
    _completedTicketSubscription =
        _ticketInteractor.execute(TicketPages.completed).listen(
              (result) => result.fold(
                _handleGetCompletedTicketsFailure,
                _handleGetCompletedTicketsSuccess,
              ),
            );

    return;
  }

  void _getCancelledTickets() {
    _cancelledTicketSubscription =
        _ticketInteractor.execute(TicketPages.cancelled).listen(
              (result) => result.fold(
                _handleGetCancelledTicketsFailure,
                _handleGetCancelledTicketsSuccess,
              ),
            );

    return;
  }

  void _handleGetOnGoingTicketsSuccess(Success success) {
    loggy.info('_handleGetOnGoingTicketsSuccess(): $success');
    if (success is GetUserTicketsSuccess) {
      onGoingTicketsNotifier.value = success;
    } else if (success is GetUserTicketsIsEmpty) {
      onGoingTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetCompletedTicketsSuccess(Success success) {
    loggy.info('_handleGetCompletedTicketsSuccess(): $success');
    if (success is GetUserTicketsSuccess) {
      completedTicketsNotifier.value = success;
    } else if (success is GetUserTicketsIsEmpty) {
      completedTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetCancelledTicketsSuccess(Success success) {
    loggy.info('_handleGetCancelledTicketsSuccess(): $success');
    if (success is GetUserTicketsSuccess) {
      cancelledTicketsNotifier.value = success;
    } else if (success is GetUserTicketsIsEmpty) {
      cancelledTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetOnGoingTicketsFailure(Failure failure) {
    loggy.error('_handleGetOnGoingTicketsFailure(): $failure');
    if (failure is GetUserTicketsFailure) {
      onGoingTicketsNotifier.value = failure;
    }

    return;
  }

  void _handleGetCompletedTicketsFailure(Failure failure) {
    loggy.error('_handleGetCompletedTicketsFailure(): $failure');
    if (failure is GetUserTicketsFailure) {
      completedTicketsNotifier.value = failure;
    }

    return;
  }

  void _handleGetCancelledTicketsFailure(Failure failure) {
    loggy.error('_handleGetCancelledTicketsFailure(): $failure');
    if (failure is GetUserTicketsFailure) {
      cancelledTicketsNotifier.value = failure;
    }

    return;
  }

  void _disposeNotifiers() {
    onGoingTicketsNotifier.dispose();
    completedTicketsNotifier.dispose();
    cancelledTicketsNotifier.dispose();
    cancelTicketNotifier.dispose();
  }

  void _cancelSubscriptions() {
    _onGoingTicketSubscription?.cancel();
    _completedTicketSubscription?.cancel();
    _cancelledTicketSubscription?.cancel();
    _cancelTicketSubscription?.cancel();
    _onGoingTicketSubscription = null;
    _completedTicketSubscription = null;
    _cancelledTicketSubscription = null;
    _cancelTicketSubscription = null;
  }

  void _onTabIndexChangedListener() {
    loggy.info('_onTabIndexChangedListener(): ${tabController.index}');
    currentPage = TicketPages.values[tabController.index];
    _getTicketsForPage(currentPage);
  }

  void cancelBooking() {
    loggy.info('cancelBooking()');

    final ticketId = _bookingService.selectedTicketId;

    if (ticketId == null) {
      loggy.error('Ticket id is null');
      return;
    }

    _cancelTicketSubscription =
        _cancelTicketInteractor.execute(ticketId).listen(
              (result) => result.fold(
                _handleCancelTicketFailure,
                _handleCancelTicketSuccess,
              ),
            );
  }

  void viewTicket(Ticket ticket) {
    loggy.info('viewTicket()');
    final profile = _accountService.profile;

    if (profile == null) {
      DialogUtils.showRequiredLogin(context);
    } else if (profile.phone == null || profile.phone!.isEmpty) {
      DialogUtils.showRequiredFillProfile(context);
    } else {
      _bookingService.setSelectedTicketId(ticket.id);
    }
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.ticketDetails,
    );
  }

  void _handleCancelTicketSuccess(Success success) {
    loggy.info('_handleCancelTicketSuccess(): $success');
    if (success is CancelTicketSuccess) {
      cancelTicketNotifier.value = success;
      _getTicketsForPage(currentPage);
    } else if (success is CancelTicketLoading) {
      cancelTicketNotifier.value = success;
    }
  }

  void _handleCancelTicketFailure(Failure failure) {
    loggy.error('_handleCancelTicketFailure(): $failure');
    if (failure is CancelTicketFailure) {
      cancelTicketNotifier.value = failure;
    } else if (failure is CancelTicketEmpty) {
      cancelTicketNotifier.value = failure;
    } else {
      cancelTicketNotifier.value =
          const CancelTicketFailure(exception: 'Unknown error');
    }
  }

  @override
  Widget build(BuildContext context) => MyTicketsView(controller: this);
}
