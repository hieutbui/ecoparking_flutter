import 'dart:async';
import 'dart:convert';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_config.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:ecoparking_flutter/data/supabase_data/tables/ticket_table.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_ticket_info_state.dart';
import 'package:ecoparking_flutter/domain/usecase/tickets/get_ticket_info_interactor.dart';
import 'package:ecoparking_flutter/model/ticket/qr_data.dart';
import 'package:ecoparking_flutter/pages/ticket_details/models/scanned_ticket_info.dart';
import 'package:ecoparking_flutter/pages/ticket_details/ticket_details_view.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:geobase/geobase.dart' hide Coords;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final ValueNotifier<bool> isExitTicket = ValueNotifier<bool>(false);

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
    _listenRealtimeChanges();
    _listenBroadcastError();
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

  void _listenRealtimeChanges() {
    const realtimePurpose = 'scan_ticket';

    Supabase.instance.client
        .channel('${AppConfig.appTitle}/$realtimePurpose')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          callback: _handleRealtimeChanges,
          schema: 'public',
        )
        .subscribe();
  }

  void _listenBroadcastError() {
    final key = selectedTicketId ?? ticket?.id;

    if (key == null) {
      return;
    }

    final channelName = 'error_$key';

    Supabase.instance.client
        .channel(
          channelName,
          opts: RealtimeChannelConfig(
            key: key,
          ),
        )
        .onBroadcast(
          event: 'scan_ticket_error',
          callback: _handleBroadcastError,
        )
        .subscribe();
  }

  void _handleBroadcastError(Map<String, dynamic> payload) async {
    loggy.info('Broadcast error: $payload');

    await DialogUtils.show(
      context: context,
      title: 'Error',
      description:
          'Error occurred while scanning the ticket.\n If you did not scan the ticket, please contact the parking lot staff.',
      svgImage: ImagePaths.imgDialogError,
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'OK',
            onPressed: () {
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void _handleRealtimeChanges(PostgresChangePayload payload) {
    loggy.info('Realtime changes: $payload');
    const table = TicketTable();
    if (payload.schema == 'public' && payload.table == table.tableName) {
      try {
        final ticketInfo = ScannedTicketInfo.fromJson(payload.newRecord);

        if (ticket != null && ticket?.id == ticketInfo.id) {
          _showScannedDialog(ticketInfo);
        } else if (selectedTicketId != null &&
            selectedTicketId == ticketInfo.id) {
          _showScannedDialog(ticketInfo);
        }
      } catch (e) {
        _showScanFailedDialog();
      }
    }
  }

  void _showScannedDialog(ScannedTicketInfo ticketInfo) {
    if (ticketInfo.entryTime != null && ticketInfo.exitTime != null) {
      _showExitDialog();
    } else if (ticketInfo.entryTime != null) {
      _showEntryDialog();
    }
  }

  void _showEntryDialog() {
    DialogUtils.show(
      context: context,
      title: 'Success',
      description: 'You have arrived at the parking lot!',
      svgImage: ImagePaths.imgDialogSuccessful,
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'OK',
            onPressed: () {
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void _showExitDialog() {
    DialogUtils.show(
      context: context,
      title: 'Success',
      description: 'You have left the parking lot!',
      svgImage: ImagePaths.imgDialogSuccessful,
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'OK',
            onPressed: () {
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void _showScanFailedDialog() {
    DialogUtils.show(
      context: context,
      title: 'Scan Failed',
      description: 'Please try again',
      svgImage: ImagePaths.imgDialogError,
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'OK',
            onPressed: () {
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
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
      timeType: isExitTicket.value ? QrTimeType.exit : QrTimeType.entry,
    );

    qrDataNotifier.value = QrCode.fromData(
      data: jsonEncode(qrData.toJson()),
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );
  }

  void toggleExitTicket(bool? value) {
    isExitTicket.value = value ?? false;
    _setQrData();
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
