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
  final void Function()? onCancelBooking;
  final void Function()? onViewTicket;

  const TicketCard({
    super.key,
    required this.ticket,
    required this.page,
    this.onCancelBooking,
    this.onViewTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              GFImageOverlay(
                height: 98,
                width: 98,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle,
                image: NetworkImage(ticket.image, scale: 1),
              ),
              const SizedBox(width: 12),
              Column(
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
                          text: '${ticket.days} days + ',
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA1A1A1),
                          ),
                        ),
                      ],
                      TextSpan(
                        text: '${ticket.hours} hours',
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
              )
            ],
          ),
          Text(
            ticket.address,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: const Color(0xFFA1A1A1)),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(
            height: 1,
            color: Color(0xFFCACACA),
          ),
          renderButtonsRow(
            page,
            onCancelBooking: onCancelBooking,
            onViewTicket: onViewTicket,
          ),
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
    void Function()? onCancelBooking,
    void Function()? onViewTicket,
  }) {
    switch (page) {
      case TicketPages.onGoing:
        return Row(
          children: <Widget>[
            ActionButton(
              type: ActionButtonType.hollow,
              label: 'Cancel Booking',
              onPressed: onCancelBooking,
            ),
            const SizedBox(width: 10),
            ActionButton(
              type: ActionButtonType.positive,
              label: 'View Ticket',
              onPressed: onViewTicket,
            ),
          ],
        );
      case TicketPages.completed:
        return ActionButton(
          type: ActionButtonType.positive,
          label: 'View Ticket',
          onPressed: onViewTicket,
        );
      default:
        return const SizedBox();
    }
  }
}
