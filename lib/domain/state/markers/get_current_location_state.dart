import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:location/location.dart';

abstract class GetCurrentLocationState {
  const GetCurrentLocationState();

  List<Object?> get props => [];
}

class GetCurrentLocationInitial extends Initial
    implements GetCurrentLocationState {
  const GetCurrentLocationInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetCurrentLocationSuccess extends Success
    implements GetCurrentLocationState {
  final LocationData currentLocation;

  const GetCurrentLocationSuccess({required this.currentLocation});

  @override
  List<Object?> get props => [currentLocation];
}

class GetCurrentLocationIsEmpty extends Failure
    implements GetCurrentLocationState {
  const GetCurrentLocationIsEmpty();

  @override
  List<Object?> get props => [];
}

class GetCurrentLocationFailure extends Failure
    implements GetCurrentLocationState {
  final dynamic exception;

  const GetCurrentLocationFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
