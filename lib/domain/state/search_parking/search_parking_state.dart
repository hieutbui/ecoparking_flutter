import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:equatable/equatable.dart';

abstract class SearchParkingState with EquatableMixin {
  const SearchParkingState();

  @override
  List<Object?> get props => [];
}

class SearchParkingInitial extends Initial implements SearchParkingState {
  const SearchParkingInitial() : super();

  @override
  List<Object?> get props => [];
}

class SearchParkingLoading extends Initial implements SearchParkingState {
  const SearchParkingLoading() : super();

  @override
  List<Object?> get props => [];
}

class SearchParkingSuccess extends Success implements SearchParkingState {
  final List<Parking> parkingList;

  const SearchParkingSuccess({required this.parkingList});

  @override
  List<Object?> get props => [parkingList];
}

class SearchParkingIsEmpty extends Success implements SearchParkingState {
  const SearchParkingIsEmpty();

  @override
  List<Object?> get props => [];
}

class SearchParkingFailure extends Failure implements SearchParkingState {
  final dynamic exception;

  const SearchParkingFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
