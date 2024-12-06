import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/account/vehicle.dart';
import 'package:equatable/equatable.dart';

class AddNewVehicleState with EquatableMixin {
  const AddNewVehicleState();

  @override
  List<Object?> get props => [];
}

class AddNewVehicleInitial extends Initial implements AddNewVehicleState {
  const AddNewVehicleInitial();

  @override
  List<Object?> get props => [];
}

class AddNewVehicleLoading extends Initial implements AddNewVehicleState {
  const AddNewVehicleLoading();

  @override
  List<Object?> get props => [];
}

class AddNewVehicleSuccess extends Success implements AddNewVehicleState {
  final Vehicle vehicle;

  const AddNewVehicleSuccess({required this.vehicle});

  @override
  List<Object?> get props => [vehicle];
}

class AddNewVehicleFailure extends Failure implements AddNewVehicleState {
  final dynamic exception;

  const AddNewVehicleFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class AddNewVehicleIsEmpty extends Failure implements AddNewVehicleState {
  const AddNewVehicleIsEmpty();

  @override
  List<Object?> get props => [];
}
