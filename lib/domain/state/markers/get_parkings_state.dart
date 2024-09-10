import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:equatable/equatable.dart';

abstract class GetParkingsState with EquatableMixin {
  const GetParkingsState();

  @override
  List<Object?> get props => [];
}

class GetParkingsInitial extends Initial implements GetParkingsState {
  const GetParkingsInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetParkingsSuccess extends Success implements GetParkingsState {
  final List<Parking> parkings;

  const GetParkingsSuccess({required this.parkings});

  @override
  List<Object?> get props => [parkings];
}

class GetParkingsIsEmpty extends Success implements GetParkingsState {
  const GetParkingsIsEmpty();

  @override
  List<Object?> get props => [];
}

class GetParkingsFailure extends Failure implements GetParkingsState {
  final dynamic exception;

  const GetParkingsFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
