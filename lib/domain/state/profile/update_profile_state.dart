import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateProfileState with EquatableMixin {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileInitial extends Initial implements UpdateProfileState {
  const UpdateProfileInitial() : super();

  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccess extends Success implements UpdateProfileState {
  final Profile profile;

  const UpdateProfileSuccess({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class UpdateProfileEmptyProfile extends Failure implements UpdateProfileState {
  const UpdateProfileEmptyProfile();

  @override
  List<Object?> get props => [];
}

class UpdateProfileFailure extends Failure implements UpdateProfileState {
  final dynamic exception;

  const UpdateProfileFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
