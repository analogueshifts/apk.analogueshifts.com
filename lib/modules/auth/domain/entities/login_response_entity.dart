import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  LoginResponse({
    required this.status,
    required this.token,
    required this.user,
  });

  final int? status;
  final String? token;
  final User? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      status: json["status"],
      token: json["token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  @override
  List<Object?> get props => [
    status, token, user, ];
}

class User extends Equatable {
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
  final dynamic googleToken;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      tel: json["tel"],
      role: json["role"],
      profile: json["profile"],
      googleToken: json["google_token"],
      emailVerifiedAt: json["email_verified_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  @override
  List<Object?> get props => [
    id, name, username, email, tel, role, profile, googleToken, emailVerifiedAt, createdAt, updatedAt, ];
}
