import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/account/vehicle.dart';
import 'package:equatable/equatable.dart';

abstract class GetUserVehiclesState with EquatableMixin {
  const GetUserVehiclesState();

  @override
  List<Object?> get props => [];
}

class GetUserVehiclesInitial extends Initial implements GetUserVehiclesState {
  const GetUserVehiclesInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetUserVehiclesSuccess extends Success implements GetUserVehiclesState {
  final List<Vehicle> vehicles;

  const GetUserVehiclesSuccess({required this.vehicles});

  @override
  List<Object?> get props => [vehicles];
}

class GetUserVehiclesIsEmpty extends Failure implements GetUserVehiclesState {
  const GetUserVehiclesIsEmpty() : super();

  @override
  List<Object?> get props => [];
}

class GetUserVehiclesFailure extends Failure implements GetUserVehiclesState {
  final dynamic exception;

  const GetUserVehiclesFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
