import 'package:ecoparking_flutter/model/account/account.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile with EquatableMixin {
  final String id;
  final String email;
  final AccountType? type;
  final String? phone;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? avatar;
  final DateTime? dob;
  final Genders? gender;
  @JsonKey(name: 'favorite_parking')
  final List<String>? favoriteParkings;

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
    this.favoriteParkings,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Profile copyWith({
    String? id,
    String? email,
    AccountType? type,
    String? phone,
    String? fullName,
    String? displayName,
    String? avatar,
    DateTime? dob,
    Genders? gender,
    List<String>? favoriteParkings,
  }) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
      type: type ?? this.type,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      avatar: avatar ?? this.avatar,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      favoriteParkings: favoriteParkings ?? this.favoriteParkings,
    );
  }

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
        favoriteParkings,
      ];
}
