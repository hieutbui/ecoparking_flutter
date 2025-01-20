import 'package:ecoparking_flutter/model/ticket/ticket.dart';
import 'package:ecoparking_flutter/model/ticket/ticket_status.dart';
import 'package:ecoparking_flutter/pages/my_tickets/model/ticket_pages.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final TicketPages page;
  final void Function(Ticket)? onCancelBooking;
  final void Function(Ticket)? onViewTicket;

  const TicketCard({
    super.key,
    required this.ticket,
    required this.page,
    this.onCancelBooking,
    this.onViewTicket,
  });

  @override
  Widget build(BuildContext context) {
    final parkingImage = ticket.parkingImage;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GFImageOverlay(
                height: 98,
                width: 98,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle,
                image: parkingImage != null
                    ? NetworkImage(parkingImage, scale: 1)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ticket.parkingName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.black),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RichText(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: <InlineSpan>[
                        TextSpan(
                          text: ticket.total.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' / ',
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA1A1A1),
                          ),
                        ),
                        if (ticket.days != 0) ...[
                          TextSpan(
                            text: '${ticket.days} ngày + ',
                            style: GoogleFonts.montserrat(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFA1A1A1),
                            ),
                          ),
                        ],
                        TextSpan(
                          text: '${ticket.hours} giờ',
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA1A1A1),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 8),
                    renderTicketStatus(context, ticket.status),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            ticket.parkingAddress,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: const Color(0xFFA1A1A1)),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10.0),
          if (ticket.status != TicketStatus.cancelled) ...[
            const Divider(
              height: 1,
              color: Color(0xFFCACACA),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: renderButtonsRow(
                page,
                onCancelBooking: onCancelBooking,
                onViewTicket: onViewTicket,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget renderTicketStatus(BuildContext context, TicketStatus status) {
    Color statusBackgroundColor;
    Color statusBorderColor;
    Color statusTextColor;

    switch (status) {
      case TicketStatus.active:
        statusBackgroundColor = Theme.of(context).colorScheme.primary;
        statusBorderColor = Colors.transparent;
        statusTextColor = Colors.white;
        break;
      case TicketStatus.completed:
        statusBackgroundColor = Colors.transparent;
        statusBorderColor = const Color(0xFF01DB3E);
        statusTextColor = const Color(0xFF01DB3E);
        break;
      case TicketStatus.cancelled:
        statusBackgroundColor = Colors.transparent;
        statusBorderColor = Theme.of(context).colorScheme.error;
        statusTextColor = Theme.of(context).colorScheme.error;
        break;
      case TicketStatus.paid:
        statusBackgroundColor = Colors.transparent;
        statusBorderColor = Theme.of(context).colorScheme.primary;
        statusTextColor = Theme.of(context).colorScheme.primary;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: statusBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          color: statusBorderColor,
          width: 2,
        ),
      ),
      child: Text(
        status.name,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: statusTextColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget renderButtonsRow(
    TicketPages page, {
    void Function(Ticket)? onCancelBooking,
    void Function(Ticket)? onViewTicket,
  }) {
    switch (page) {
      case TicketPages.onGoing:
        return Row(
          children: <Widget>[
            Expanded(
              child: ActionButton(
                type: ActionButtonType.hollow,
                label: 'Hủy vé',
                onPressed: () {
                  if (onCancelBooking != null) {
                    onCancelBooking(ticket);
                  }
                },
                height: 36,
                // padding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ActionButton(
                type: ActionButtonType.positive,
                label: 'Xem vé',
                onPressed: () {
                  if (onViewTicket != null) {
                    onViewTicket(ticket);
                  }
                },
                height: 36,
                // padding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
          ],
        );
      case TicketPages.completed:
        return ActionButton(
          type: ActionButtonType.positive,
          label: 'Xem vé',
          onPressed: () {
            if (onViewTicket != null) {
              onViewTicket(ticket);
            }
          },
          height: 36,
          // padding: const EdgeInsets.symmetric(vertical: 8.0),
        );
      default:
        return const SizedBox();
    }
  }
}
