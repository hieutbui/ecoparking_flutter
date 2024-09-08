import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

class MarkerData with EquatableMixin {
  final LocationData? center;
  final List<Parking>? parkings;

  MarkerData({
    this.center,
    this.parkings,
  });

  @override
  List<Object?> get props => [center, parkings];
}
