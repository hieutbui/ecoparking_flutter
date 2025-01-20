import 'package:ecoparking_flutter/domain/state/tickets/get_user_tickets_state.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';
import 'package:ecoparking_flutter/pages/my_tickets/model/ticket_pages.dart';
import 'package:ecoparking_flutter/pages/my_tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

class ListTicket extends StatelessWidget {
  final ValueNotifier<GetUserTicketsState> ticketsNotifier;
  final TicketPages page;
  final void Function(Ticket)? onCancelBooking;
  final void Function(Ticket)? onViewTicket;

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
            child: Text('Không có dữ liệu'),
          );
        }

        if (getUserTicketState is GetUserTicketsFailure) {
          return Center(
            child: Column(
              children: [
                const Text('Có lỗi xảy ra!'),
                Text(getUserTicketState.exception.toString()),
              ],
            ),
          );
        }

        if (getUserTicketState is GetUserTicketsSuccess) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: getUserTicketState.tickets.length,
                itemBuilder: (context, index) {
                  final ticket = getUserTicketState.tickets[index];

                  return Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TicketCard(
                      ticket: ticket,
                      page: page,
                      onCancelBooking: onCancelBooking,
                      onViewTicket: onViewTicket,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8.0,
                  );
                },
              ),
            ),
          );
        }

        return child!;
      },
      child: const SizedBox(),
    );
  }
}
