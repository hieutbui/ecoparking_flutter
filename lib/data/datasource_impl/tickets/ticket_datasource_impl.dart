import 'package:ecoparking_flutter/data/datasource/tickets/ticket_datasource.dart';
import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:ecoparking_flutter/data/supabase_data/database_functions_name.dart';
import 'package:ecoparking_flutter/data/supabase_data/tables/ticket_table.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';

class TicketDataSourceImpl implements TicketDataSource {
  @override
  Future<List<dynamic>?> fetchOnGoingTickets() async {
    return SupabaseUtils().client.rpc(
          DatabaseFunctionsName.getOngoingTickets.functionName,
        );
  }

  @override
  Future<List<dynamic>?> fetchCompletedTickets() async {
    return SupabaseUtils().client.rpc(
          DatabaseFunctionsName.getCompletedTickets.functionName,
        );
  }

  @override
  Future<List<dynamic>?> fetchCancelledTickets() async {
    return SupabaseUtils().client.rpc(
          DatabaseFunctionsName.getCancelledTickets.functionName,
        );
  }

  @override
  Future<Map<String, dynamic>?> createTicket(
    CreateTicketRequestData ticket,
  ) async {
    const table = TicketTable();

    return await SupabaseUtils()
        .client
        .from(table.tableName)
        .insert(
          ticket,
        )
        .select()
        .single();
  }

  @override
  Future<List<dynamic>?> getTicketInfo(String ticketId) async {
    return SupabaseUtils().client.rpc(
      DatabaseFunctionsName.getTicketInfo.functionName,
      params: {
        'ticket_id': ticketId,
      },
    );
  }

  @override
  Future<String> cancelTicket(String ticketId) async {
    return SupabaseUtils().client.rpc(
      DatabaseFunctionsName.cancelTicket.functionName,
      params: {
        'ticket_id': ticketId,
      },
    );
  }
}
