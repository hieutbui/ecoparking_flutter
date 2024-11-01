import 'package:ecoparking_flutter/domain/state/tickets/get_user_tickets_state.dart';
import 'package:ecoparking_flutter/pages/my_tickets/model/ticket_pages.dart';
import 'package:ecoparking_flutter/pages/my_tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

class ListTicket extends StatelessWidget {
  final ValueNotifier<GetUserTicketsState> ticketsNotifier;
  final TicketPages page;
  final void Function()? onCancelBooking;
  final void Function()? onViewTicket;

  const ListTicket({
    super.key,
    required this.ticketsNotifier,
    required this.page,
    this.onCancelBooking,
    this.onViewTicket,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ticketsNotifier,
      builder: (context, getUserTicketState, child) {
        if (getUserTicketState is GetUserTicketsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (getUserTicketState is GetUserTicketsIsEmpty) {
          return const Center(
            child: Text('No tickets found'),
          );
        }

        if (getUserTicketState is GetUserTicketsFailure) {
          return Center(
            child: Column(
              children: [
                const Text('Something went wrong:'),
                Text(getUserTicketState.exception.toString()),
              ],
            ),
          );
        }

        if (getUserTicketState is GetUserTicketsSuccess) {
          return ListView.separated(
            itemCount: getUserTicketState.tickets.length,
            itemBuilder: (context, index) {
              final ticket = getUserTicketState.tickets[index];

              return TicketCard(
                ticket: ticket,
                page: page,
                onCancelBooking: onCancelBooking,
                onViewTicket: onViewTicket,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 8.0,
              );
            },
          );
        }

        return child!;
      },
      child: const SizedBox(),
    );
  }
}
