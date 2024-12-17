import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/domain/state/tickets/get_ticket_info_state.dart';
import 'package:ecoparking_flutter/model/ticket/ticket_status.dart';
import 'package:ecoparking_flutter/pages/ticket_details/ticket_details.dart';
import 'package:ecoparking_flutter/pages/ticket_details/ticket_details_view_styles.dart';
import 'package:ecoparking_flutter/pages/ticket_details/widgets/dash_separator.dart';
import 'package:ecoparking_flutter/pages/ticket_details/widgets/ticket_info_field.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketDetailsView extends StatelessWidget {
  final TicketDetailsController controller;

  const TicketDetailsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.ticketDetails.getTitle(),
      onBackButtonPressed: controller.onBackButtonPressed,
      body: ValueListenableBuilder(
        valueListenable: controller.ticketInfoState,
        builder: (context, state, child) {
          if (state is GetTicketInfoFailure || state is GetTicketInfoEmpty) {
            return Center(
              child: Text(
                'Could not load ticket info',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color(0xFFA1A1A1),
                    ),
              ),
            );
          }

          if (state is GetTicketInfoLoading) {
            return child!;
          }

          if (state is GetTicketInfoSuccess) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xFFCACACA),
                                      width: 2.0,
                                    ),
                                    left: BorderSide(
                                      color: Color(0xFFCACACA),
                                      width: 2.0,
                                    ),
                                    right: BorderSide(
                                      color: Color(0xFFCACACA),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: const Color(0xFFA1A1A1),
                                            ),
                                        children: <InlineSpan>[
                                          if (state.ticket.status ==
                                                  TicketStatus.active ||
                                              state.ticket.status ==
                                                  TicketStatus.paid) ...[
                                            const TextSpan(
                                                text:
                                                    'Scan this on the scanner machine\n'),
                                            const TextSpan(
                                              text:
                                                  'when you are in the parking lot',
                                            ),
                                          ] else ...[
                                            const TextSpan(
                                              text: 'This ticket is done\n',
                                            )
                                          ]
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    if (state.ticket.status ==
                                            TicketStatus.active ||
                                        state.ticket.status ==
                                            TicketStatus.paid) ...[
                                      ValueListenableBuilder(
                                        valueListenable:
                                            controller.qrDataNotifier,
                                        builder: (context, qrData, child) {
                                          return QrImageView.withQr(
                                            qr: qrData,
                                            version: QrVersions.max,
                                            size: 200.0,
                                          );
                                        },
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                              const DashSeparator(),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFCACACA),
                                  width: 2.0,
                                ),
                                left: BorderSide(
                                  color: Color(0xFFCACACA),
                                  width: 2.0,
                                ),
                                right: BorderSide(
                                  color: Color(0xFFCACACA),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Table(
                              columnWidths: const <int, TableColumnWidth>{
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                              },
                              children: <TableRow>[
                                TableRow(
                                  children: <Widget>[
                                    TicketInfoField(
                                      name: 'Parking Name',
                                      value: state.ticket.parkingName,
                                    ),
                                    TicketInfoField(
                                      name: 'Vehicle',
                                      value:
                                          '${state.ticket.vehicleName} (${state.ticket.licensePlate})',
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    TicketInfoField(
                                      name: 'Parking Address',
                                      value: state.ticket.parkingAddress,
                                    ),
                                    TicketInfoField(
                                      name: 'Duration',
                                      value:
                                          '${state.ticket.days} days ${state.ticket.hours} hours',
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    TicketInfoField(
                                      name: 'Start Time',
                                      value: controller.formatDateTime(
                                        state.ticket.startTime,
                                      ),
                                    ),
                                    TicketInfoField(
                                      name: 'End Time',
                                      value: controller.formatDateTime(
                                        state.ticket.endTime,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: TicketDetailsViewStyles.bottomContainerPadding,
                  decoration: TicketDetailsViewStyles.bottomContainerDecoration,
                  child: ActionButton(
                    type: ActionButtonType.positive,
                    label: 'Navigate to Parking',
                    onPressed: controller.onNavigateToParking,
                  ),
                )
              ],
            );
          }

          return child!;
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
