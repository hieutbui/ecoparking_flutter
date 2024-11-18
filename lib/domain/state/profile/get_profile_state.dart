import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:equatable/equatable.dart';

abstract class GetProfileState with EquatableMixin {
  const GetProfileState();

  @override
  List<Object?> get props => [];
}

class GetProfileInitial extends Initial implements GetProfileState {
  const GetProfileInitial() : super();

  @override
  List<Object?> get props => [];
}

class GetProfileSuccess extends Success implements GetProfileState {
  final Profile profile;

  const GetProfileSuccess({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class GetProfileEmptyProfile extends Failure implements GetProfileState {
  const GetProfileEmptyProfile();

  @override
  List<Object?> get props => [];
}

class GetProfileFailure extends Failure implements GetProfileState {
  final dynamic exception;

  const GetProfileFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
