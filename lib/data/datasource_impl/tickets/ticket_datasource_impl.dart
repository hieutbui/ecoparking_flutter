import 'package:ecoparking_flutter/data/datasource/tickets/ticket_datasource.dart';
import 'package:ecoparking_flutter/data/supabase_data/database_functions_name.dart';
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
}
