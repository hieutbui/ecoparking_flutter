import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/parking/add_favorite_parking_response.dart';
import 'package:equatable/equatable.dart';

class AddFavoriteParkingState with EquatableMixin {
  const AddFavoriteParkingState();

  @override
  List<Object?> get props => [];
}

class AddFavoriteParkingInitial extends Initial
    implements AddFavoriteParkingState {
  const AddFavoriteParkingInitial();

  @override
  List<Object?> get props => [];
}

class AddFavoriteParkingLoading extends Initial
    implements AddFavoriteParkingState {
  const AddFavoriteParkingLoading();

  @override
  List<Object?> get props => [];
}

class AddFavoriteParkingSuccess extends Success
    implements AddFavoriteParkingState {
  final AddFavoriteParkingResponse response;

  const AddFavoriteParkingSuccess({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}

class AddFavoriteParkingEmpty extends Failure
    implements AddFavoriteParkingState {
  const AddFavoriteParkingEmpty();

  @override
  List<Object?> get props => [];
}

class AddFavoriteParkingFailure extends Failure
    implements AddFavoriteParkingState {
  final dynamic exception;

  const AddFavoriteParkingFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
