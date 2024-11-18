import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

enum Genders {
  male,
  female,
  others;

  @override
  String toString() {
    switch (this) {
      case male:
        return 'male';
      case female:
        return 'female';
      case others:
        return 'others';
    }
  }
}

enum AccountType {
  user,
  employee,
  parkingOwner;

  @override
  String toString() {
    switch (this) {
      case user:
        return 'user';
      case employee:
        return 'employee';
      case parkingOwner:
        return 'parkingOwner';
    }
  }
}

@JsonSerializable()
class Account with EquatableMixin {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final AccountType type;
  final String email;
  final String password;
  final String phone;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'user_name')
  final String userName;
  final String avatar;
  final Genders gender;
  @JsonKey(name: 'date_of_birth')
  final DateTime dob;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Account({
    required this.id,
    required this.userId,
    required this.type,
    required this.email,
    required this.password,
    required this.phone,
    required this.fullName,
    required this.userName,
    required this.avatar,
    required this.gender,
    required this.dob,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        email,
        password,
        phone,
        fullName,
        userName,
        avatar,
      ];
}
