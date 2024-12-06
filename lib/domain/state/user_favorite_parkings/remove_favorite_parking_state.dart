import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/data/models/parking/remove_favorite_parking_response.dart';
import 'package:equatable/equatable.dart';

class RemoveFavoriteParkingState with EquatableMixin {
  const RemoveFavoriteParkingState();

  @override
  List<Object?> get props => [];
}

class RemoveFavoriteParkingInitial extends Initial
    implements RemoveFavoriteParkingState {
  const RemoveFavoriteParkingInitial();

  @override
  List<Object?> get props => [];
}

class RemoveFavoriteParkingLoading extends Initial
    implements RemoveFavoriteParkingState {
  const RemoveFavoriteParkingLoading();

  @override
  List<Object?> get props => [];
}

class RemoveFavoriteParkingSuccess extends Success
    implements RemoveFavoriteParkingState {
  final RemoveFavoriteParkingResponse response;

  const RemoveFavoriteParkingSuccess({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}

class RemoveFavoriteParkingEmpty extends Failure
    implements RemoveFavoriteParkingState {
  const RemoveFavoriteParkingEmpty();

  @override
  List<Object?> get props => [];
}

class RemoveFavoriteParkingFailure extends Failure
    implements RemoveFavoriteParkingState {
  final dynamic exception;

  const RemoveFavoriteParkingFailure({
    required this.exception,
  });

  @override
  List<Object?> get props => [exception];
}
