import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:equatable/equatable.dart';

abstract class FindNearbyParkingsState with EquatableMixin {
  const FindNearbyParkingsState();

  @override
  List<Object?> get props => [];
}

class FindNearbyParkingsInitial extends Initial
    implements FindNearbyParkingsState {
  const FindNearbyParkingsInitial() : super();

  @override
  List<Object?> get props => [];
}

class FindNearbyParkingsLoading extends Initial
    implements FindNearbyParkingsState {
  const FindNearbyParkingsLoading() : super();

  @override
  List<Object?> get props => [];
}

class FindNearbyParkingsSuccess extends Success
    implements FindNearbyParkingsState {
  final List<Parking> parkings;

  const FindNearbyParkingsSuccess({required this.parkings});

  @override
  List<Object?> get props => [parkings];
}

class FindNearbyParkingsIsEmpty extends Success
    implements FindNearbyParkingsState {
  const FindNearbyParkingsIsEmpty();

  @override
  List<Object?> get props => [];
}

class FindNearbyParkingsFailure extends Failure
    implements FindNearbyParkingsState {
  final dynamic exception;

  const FindNearbyParkingsFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
