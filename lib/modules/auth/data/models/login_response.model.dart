import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.model.g.dart';


@JsonSerializable(createToJson: false)
class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.token,
    required this.user,
  });

  final String? status;
  final String? token;
  final User? user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

}

@JsonSerializable(createToJson: false)
class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.tel,
    required this.role,
    required this.profile,
    required this.googleToken,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic tel;
  final String? role;
  final dynamic profile;

  @JsonKey(name: 'google_token')
  final dynamic googleToken;

  @JsonKey(name: 'email_verified_at')
  final dynamic emailVerifiedAt;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}
