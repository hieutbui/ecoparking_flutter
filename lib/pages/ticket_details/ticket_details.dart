import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_ticket_info_state.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/get_ticket_info_interactor.dart';
import 'package:ecoparking_flutter/model/ticket/qr_data.dart';
import 'package:ecoparking_flutter/pages/ticket_details/ticket_details_view.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:flutter/material.dart';
import 'package:geobase/geobase.dart' hide Coords;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final ValueNotifier<QrCode> qrDataNotifier = ValueNotifier<QrCode>(
    QrCode.fromData(
      data: '',
      errorCorrectLevel: QrErrorCorrectLevel.L,
    ),
  );

  CreateTicketRequestData? get ticket => _bookingService.createdTicket;
  String? get selectedTicketId => _bookingService.selectedTicketId;

  Point? parkingGeolocation;
  Timer? _qrDataTimer;

  StreamSubscription? _ticketInfoSubscription;

  @override
  void initState() {
    super.initState();
    _getTicketInfo();
    _startQrTimer();
    loggy.info('TicketDetailsController initialized');
  }

  @override
  void dispose() {
    loggy.info('TicketDetailsController disposed');
    _cancelTicketInfoSubscriptions();
    _disposeNotifiers();
    _disposeTimer();
    super.dispose();
  }

  void _startQrTimer() {
    _setQrData();

    _qrDataTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        _setQrData();
      },
    );
  }

  void _setQrData() {
    final ticketId = ticket?.id ?? selectedTicketId;
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final qrData = QrData(
      ticketId: ticketId ?? '',
      timestamp: timestamp,
    );

    qrDataNotifier.value = QrCode.fromData(
      data: qrData.toJson().toString(),
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );
  }

  void _cancelTicketInfoSubscriptions() {
    _ticketInfoSubscription?.cancel();
  }

  void _disposeNotifiers() {
    ticketInfoState.dispose();
    qrDataNotifier.dispose();
  }

  void _disposeTimer() {
    _qrDataTimer?.cancel();
  }

  void _getTicketInfo() {
    _ticketInfoSubscription = _getTicketInfoInteractor
        .execute(_bookingService.createdTicket?.id ?? selectedTicketId ?? '')
        .listen((result) => result.fold(
              _handleGetTicketInfoFailure,
              _handleGetTicketInfoSuccess,
            ));
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    NavigationUtils.navigateTo(
      context: scaffoldContext,
      path: AppPaths.booking,
    );
  }

  void onNavigateToParking() async {
    final parkingLatitude = parkingGeolocation?.position.y ??
        _bookingService.parking?.geolocation.position.y ??
        0;
    final parkingLongitude = parkingGeolocation?.position.x ??
        _bookingService.parking?.geolocation.position.x ??
        0;

    final parkingLocation = LatLng(parkingLatitude, parkingLongitude);

    if (PlatformInfos.isWeb) {
      final Uri queryUri = Uri.https(
        'www.google.com',
        'maps/dir/',
        {
          'api': '1',
          'destination':
              '${parkingLocation.latitude},${parkingLocation.longitude}',
        },
      );

      await launchUrl(queryUri);
    } else {
      final availableMaps = await MapLauncher.installedMaps;

      await availableMaps.first.showDirections(
        destination: Coords(
          parkingLocation.latitude,
          parkingLocation.longitude,
        ),
        directionsMode: DirectionsMode.driving,
      );
    }
  }

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
      parkingGeolocation = success.ticket.parkingGeolocation;
    }
  }

  @override
  Widget build(BuildContext context) => TicketDetailsView(controller: this);
}
