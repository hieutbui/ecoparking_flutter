import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:equatable/equatable.dart';

class CalculatedFee with EquatableMixin {
  final double total;
  final ParkingFeeTypes parkingFeeType;
  final int hours;

  CalculatedFee({
    required this.total,
    required this.parkingFeeType,
    required this.hours,
  });

  @override
  List<Object?> get props => [
        total,
        parkingFeeType,
        hours,
      ];
}

class HourlyFee extends CalculatedFee {
  HourlyFee({
    required super.total,
    required super.hours,
  }) : super(parkingFeeType: ParkingFeeTypes.hourly);

  @override
  List<Object?> get props => [
        total,
        hours,
        parkingFeeType,
      ];
}

class DailyFee extends CalculatedFee {
  final int days;

  DailyFee({
    required super.total,
    required super.hours,
    required this.days,
  }) : super(parkingFeeType: ParkingFeeTypes.daily);

  @override
  List<Object?> get props => [
        total,
        days,
        hours,
        parkingFeeType,
      ];
}
