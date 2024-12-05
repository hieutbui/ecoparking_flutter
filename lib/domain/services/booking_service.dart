import 'package:ecoparking_flutter/data/models/ticket/create_ticket_request_data.dart';
import 'package:ecoparking_flutter/model/account/vehicle.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/payment/e_wallet.dart';
import 'package:ecoparking_flutter/model/ticket/ticket.dart';
import 'package:ecoparking_flutter/model/ticket/ticket_status.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/calculated_fee.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/models/price_arguments.dart';
import 'package:flutter/material.dart';

class BookingService {
  Parking? _parking;
  Vehicle? _vehicle;
  ParkingFeeTypes? _parkingFeeType;
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  DateTime? _extraEndDateTime;
  final ValueNotifier<EWallet?> _paymentMethodNotifier =
      ValueNotifier<EWallet?>(null);
  PriceArguments? _calculatedPrice;
  Ticket? _ticket;
  CreateTicketRequestData? _createdTicket;
  String? _selectedTicketId;

  Parking? get parking => _parking;
  Vehicle? get vehicle => _vehicle;
  ParkingFeeTypes? get parkingFeeType => _parkingFeeType;
  DateTime? get startDateTime => _startDateTime;
  DateTime? get endDateTime => _endDateTime;
  DateTime? get extraEndDateTime => _extraEndDateTime;
  EWallet? get paymentMethod => _paymentMethodNotifier.value;
  PriceArguments? get calculatedPrice => _calculatedPrice;
  Ticket? get ticket => _ticket;
  CreateTicketRequestData? get createdTicket => _createdTicket;
  String? get selectedTicketId => _selectedTicketId;

  void setSelectedTicketId(String ticketId) {
    _selectedTicketId = ticketId;
  }

  void setParking(Parking parking) {
    _parking = parking;
  }

  void setVehicle(Vehicle vehicle) {
    _vehicle = vehicle;
  }

  void setParkingFeeType(ParkingFeeTypes parkingFeeType) {
    _parkingFeeType = parkingFeeType;
  }

  void setStartDateTime(DateTime startDateTime) {
    _startDateTime = startDateTime;
  }

  void setEndDateTime(DateTime endDateTime) {
    _endDateTime = endDateTime;
  }

  void setExtraEndDateTime(DateTime extraEndDateTime) {
    _extraEndDateTime = extraEndDateTime;
  }

  void setPaymentMethod(EWallet paymentMethod) {
    _paymentMethodNotifier.value = paymentMethod;
  }

  void setCalculatedPrice(PriceArguments calculatedPrice) {
    _calculatedPrice = calculatedPrice;
  }

  void addPaymentMethodListener(VoidCallback listener) {
    _paymentMethodNotifier.addListener(listener);
  }

  void removePaymentMethodListener(VoidCallback listener) {
    _paymentMethodNotifier.removeListener(listener);
  }

  void setTicket(Ticket ticket) {
    _ticket = ticket;
  }

  void setCreatedTicket(CreateTicketRequestData createdTicket) {
    _createdTicket = createdTicket;
  }

  void clear() {
    _parking = null;
    _vehicle = null;
    _parkingFeeType = null;
    _startDateTime = null;
    _endDateTime = null;
    _extraEndDateTime = null;
    _paymentMethodNotifier.value = null;
    _calculatedPrice = null;
    _ticket = null;
    _createdTicket = null;
    _paymentMethodNotifier.dispose();
  }

  CreateTicketRequestData createTicket({
    required String paymentIntentId,
    String? userId,
  }) {
    final days = _calculatedPrice?.calculatedFee is DailyFee
        ? (_calculatedPrice?.calculatedFee as DailyFee).days
        : 0;

    return CreateTicketRequestData(
      paymentIntentId: paymentIntentId,
      parkingId: _parking?.id ?? '',
      userId: userId ?? '',
      vehicleId: _vehicle?.id ?? '',
      startTime: _startDateTime?.toIso8601String() ?? '',
      endTime: _endDateTime?.toIso8601String() ?? '',
      days: days,
      hours: _calculatedPrice?.calculatedFee.hours ?? 0,
      total: _calculatedPrice?.calculatedFee.total ?? 0,
      status: TicketStatus.paid,
    );
  }
}
