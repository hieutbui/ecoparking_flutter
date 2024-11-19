import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/initial.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/model/account/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

class UpdateProfileLoading extends Initial implements UpdateProfileState {
  const UpdateProfileLoading() : super();

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

class UpdateProfileStorageFailure extends Failure
    implements UpdateProfileState {
  final StorageException exception;

  const UpdateProfileStorageFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class UpdateProfileUnknownFailure extends Failure
    implements UpdateProfileState {
  const UpdateProfileUnknownFailure();

  @override
  List<Object?> get props => [];
}
