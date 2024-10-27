import 'package:ecoparking_flutter/model/account/vehicle.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/payment/e_wallet.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/select_vehicle/models/price_arguments.dart';

class BookingService {
  Parking? _parking;
  Vehicle? _vehicle;
  ParkingFeeTypes? _parkingFeeType;
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  DateTime? _extraEndDateTime;
  EWallet? _paymentMethod;
  PriceArguments? _calculatedPrice;

  Parking? get parking => _parking;
  Vehicle? get vehicle => _vehicle;
  ParkingFeeTypes? get parkingFeeType => _parkingFeeType;
  DateTime? get startDateTime => _startDateTime;
  DateTime? get endDateTime => _endDateTime;
  DateTime? get extraEndDateTime => _extraEndDateTime;
  EWallet? get paymentMethod => _paymentMethod;
  PriceArguments? get calculatedPrice => _calculatedPrice;

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
    _paymentMethod = paymentMethod;
  }

  void setCalculatedPrice(PriceArguments calculatedPrice) {
    _calculatedPrice = calculatedPrice;
  }

  void clear() {
    _parking = null;
    _vehicle = null;
    _parkingFeeType = null;
    _startDateTime = null;
    _endDateTime = null;
    _extraEndDateTime = null;
    _paymentMethod = null;
    _calculatedPrice = null;
  }
}
