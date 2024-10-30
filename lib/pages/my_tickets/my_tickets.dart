import 'dart:async';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_user_tickets_state.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/ticket_interactor.dart';
import 'package:ecoparking_flutter/pages/my_tickets/model/ticket_pages.dart';
import 'package:ecoparking_flutter/pages/my_tickets/my_tickets_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:flutter/material.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  MyTicketsController createState() => MyTicketsController();
}

class MyTicketsController extends State<MyTicketsPage>
    with ControllerLoggy, TickerProviderStateMixin {
  final TicketInteractor _ticketInteractor = getIt.get<TicketInteractor>();

  final onGoingTicketsNotifier = ValueNotifier<GetUserTicketsState>(
    const GetUserTicketsInitial(),
  );
  final completedTicketsNotifier = ValueNotifier<GetUserTicketsState>(
    const GetUserTicketsInitial(),
  );
  final cancelledTicketsNotifier = ValueNotifier<GetUserTicketsState>(
    const GetUserTicketsInitial(),
  );

  StreamSubscription? _onGoingTicketSubscription;
  StreamSubscription? _completedTicketSubscription;
  StreamSubscription? _cancelledTicketSubscription;

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
    _getTicketsForPage(currentPage);

    tabController.addListener(_onTabIndexChangedListener);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    tabController.removeListener(_onTabIndexChangedListener);
    _disposeNotifiers();
    _cancelSubscriptions();
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
    } else {
      onGoingTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetCompletedTicketsSuccess(Success success) {
    loggy.info('_handleGetCompletedTicketsSuccess(): $success');
    if (success is GetUserTicketsSuccess) {
      completedTicketsNotifier.value = success;
    } else {
      completedTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetCancelledTicketsSuccess(Success success) {
    loggy.info('_handleGetCancelledTicketsSuccess(): $success');
    if (success is GetUserTicketsSuccess) {
      cancelledTicketsNotifier.value = success;
    } else {
      cancelledTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetOnGoingTicketsFailure(dynamic failure) {
    loggy.error('_handleGetOnGoingTicketsFailure(): $failure');
    if (failure is GetUserTicketsFailure) {
      onGoingTicketsNotifier.value = failure;
    } else {
      onGoingTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetCompletedTicketsFailure(dynamic failure) {
    loggy.error('_handleGetCompletedTicketsFailure(): $failure');
    if (failure is GetUserTicketsFailure) {
      completedTicketsNotifier.value = failure;
    } else {
      completedTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _handleGetCancelledTicketsFailure(dynamic failure) {
    loggy.error('_handleGetCancelledTicketsFailure(): $failure');
    if (failure is GetUserTicketsFailure) {
      cancelledTicketsNotifier.value = failure;
    } else {
      cancelledTicketsNotifier.value = const GetUserTicketsIsEmpty();
    }

    return;
  }

  void _disposeNotifiers() {
    onGoingTicketsNotifier.dispose();
    completedTicketsNotifier.dispose();
    cancelledTicketsNotifier.dispose();
  }

  void _cancelSubscriptions() {
    _onGoingTicketSubscription = null;
    _completedTicketSubscription = null;
    _cancelledTicketSubscription = null;
    _onGoingTicketSubscription?.cancel();
    _completedTicketSubscription?.cancel();
    _cancelledTicketSubscription?.cancel();
  }

  void _onTabIndexChangedListener() {
    loggy.info('_onTabIndexChangedListener(): ${tabController.index}');
    currentPage = TicketPages.values[tabController.index];
    _getTicketsForPage(currentPage);
  }

  @override
  Widget build(BuildContext context) => MyTicketsView(controller: this);
}
