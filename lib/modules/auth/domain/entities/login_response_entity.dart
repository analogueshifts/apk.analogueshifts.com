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
        this.uuid,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        this.phoneNoCode,
         this.phoneNo,
        this.tel,
        this.userType,
        required this.profile,
        this.otp,
        this.isVerified,
        this.emailVerifiedAt,
        this.deviceType,
        this.deviceToken,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    final int id;
    final String? uuid;
    final String? firstName;
    final String? lastName;
    final String? username;
    final String? email;
    final dynamic? phoneNoCode;
    final dynamic? phoneNo;
    final dynamic tel;
    final String? userType;
    final dynamic profile;
    final String? otp;
    final dynamic isVerified;
    final dynamic emailVerifiedAt;
    final dynamic deviceType;
    final dynamic deviceToken;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory User.fromJson(Map<String, dynamic> json){
        return User(
            id: json["id"],
            uuid: json["uuid"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            username: json["username"],
            email: json["email"],
            phoneNoCode: json["phone_no_code"],
            phoneNo: json["phone_no"],
            tel: json["tel"],
            userType: json["user_type"],
            profile: json["profile"],
            otp: json["OTP"],
            isVerified: json["is_verified"],
            emailVerifiedAt: json["email_verified_at"],
            deviceType: json["device_type"],
            deviceToken: json["device_token"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "phone_no_code": phoneNoCode,
        "phone_no": phoneNo,
        "tel": tel,
        "user_type": userType,
        "profile": profile,
        "OTP": otp,
        "is_verified": isVerified,
        "email_verified_at": emailVerifiedAt,
        "device_type": deviceType,
        "device_token": deviceToken,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
        id, uuid, firstName, lastName, username, email, phoneNoCode, phoneNo, tel, userType, profile, otp, isVerified, emailVerifiedAt, deviceType, deviceToken, status, createdAt, updatedAt, ];

    bool isValid() {
        return email!.isNotEmpty && username!.isNotEmpty;
    }
}
