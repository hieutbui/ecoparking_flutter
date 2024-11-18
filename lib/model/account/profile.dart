import 'package:ecoparking_flutter/model/account/account.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile with EquatableMixin {
  final String id;
  final String email;
  final AccountType type;
  final String? phone;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? avatar;
  final DateTime? dob;
  final Genders? gender;

  Profile({
    required this.id,
    required this.email,
    required this.type,
    this.phone,
    this.fullName,
    this.displayName,
    this.avatar,
    this.dob,
    this.gender,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        phone,
        fullName,
        displayName,
        avatar,
        type,
        dob,
        gender,
      ];
}
