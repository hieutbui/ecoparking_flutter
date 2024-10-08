import 'package:ecoparking_flutter/pages/book_parking_details/model/calculated_fee.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PriceArguments with EquatableMixin {
  final CalculatedFee calculatedFee;
  final ParkingFeeTypes parkingFeeType;

  PriceArguments({
    required this.calculatedFee,
    required this.parkingFeeType,
  });

  @override
  List<Object?> get props => [
        calculatedFee,
        parkingFeeType,
      ];
}

class HourlyPriceArguments extends PriceArguments {
  final TimeOfDay startHour;
  final TimeOfDay endHour;

  HourlyPriceArguments({
    required super.calculatedFee,
    required this.startHour,
    required this.endHour,
  }) : super(parkingFeeType: ParkingFeeTypes.hourly);

  @override
  List<Object?> get props => [
        calculatedFee,
        startHour,
        endHour,
        parkingFeeType,
      ];
}

class DailyPriceArguments extends PriceArguments {
  final PickerDateRange dateRange;

  DailyPriceArguments({
    required super.calculatedFee,
    required this.dateRange,
  }) : super(parkingFeeType: ParkingFeeTypes.daily);

  @override
  List<Object?> get props => [
        calculatedFee,
        dateRange,
        parkingFeeType,
      ];
}
