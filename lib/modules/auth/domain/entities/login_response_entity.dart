import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
    const LoginResponse({
        required this.status,
        required this.success,
        required this.message,
        required this.data,
    });

    final int? status;
    final bool? success;
    final String? message;
    final Data? data;

    factory LoginResponse.fromJson(Map<String, dynamic> json){ 
        return LoginResponse(
            status: json["status"],
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    @override
    List<Object?> get props => [
    status, success, message, data, ];
}

class Data extends Equatable {
    const Data({
        required this.token,
        required this.user,
    });

    final String? token;
    final User? user;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            token: json["token"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    @override
    List<Object?> get props => [
    token, user, ];
}

// ignore: must_be_immutable
class User extends Equatable {
    User({
        required this.id,
        required this.uuid,
        required this.name,
        required this.username,
        required this.email,
        required this.tel,
        required this.role,
        required this.profile,
        required this.otp,
        this.isVerified,
        this.googleToken,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? uuid;
    String? name;
    final String? username;
    final String? email;
    String? tel;
    final String? role;
    String? profile;
    final String? otp;
    final dynamic isVerified;
    final dynamic googleToken;
    final dynamic emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            uuid: json["uuid"],
            name: json["name"],
            username: json["username"],
            email: json["email"],
            tel: json["tel"],
            role: json["role"],
            profile: json["profile"],
            otp: json["OTP"],
            isVerified: json["is_verified"],
            googleToken: json["google_token"],
            emailVerifiedAt: json["email_verified_at"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    @override
    List<Object?> get props => [
    id, uuid, name, username, email, tel, role, profile, otp, isVerified, googleToken, emailVerifiedAt, createdAt, updatedAt, ];
}
