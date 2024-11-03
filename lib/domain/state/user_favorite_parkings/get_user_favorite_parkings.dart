import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/account/favorite_parkings.dart';
import 'package:equatable/equatable.dart';

abstract class GetUserFavoriteParkingsState with EquatableMixin {
  const GetUserFavoriteParkingsState();

  @override
  List<Object?> get props => [];
}

class GetUserFavoriteParkingsInitial extends Initial
    implements GetUserFavoriteParkingsState {
  const GetUserFavoriteParkingsInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetUserFavoriteParkingsSuccess extends Success
    implements GetUserFavoriteParkingsState {
  final List<FavoriteParkings> favoriteParkings;

  const GetUserFavoriteParkingsSuccess({required this.favoriteParkings});

  @override
  List<Object?> get props => [favoriteParkings];
}

class GetUserFavoriteParkingsIsEmpty extends Success
    implements GetUserFavoriteParkingsState {
  const GetUserFavoriteParkingsIsEmpty();

  @override
  List<Object?> get props => [];
}

class GetUserFavoriteParkingsFailure extends Failure
    implements GetUserFavoriteParkingsState {
  final dynamic exception;

  const GetUserFavoriteParkingsFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
