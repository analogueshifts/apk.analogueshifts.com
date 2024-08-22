import 'package:equatable/equatable.dart';

class User extends Equatable {
    User({
        required this.user,
    });

    final UserClass? user;

    factory User.fromJson(Map<String, dynamic> json){
        return User(
            user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };

    @override
    List<Object?> get props => [
        user, ];
}

class UserClass extends Equatable {
    UserClass({
        required this.uuid,
        required this.username,
        required this.email,
        required this.phoneCode,
        required this.phoneNumber,
        required this.balance,
        required this.status,
        required this.userType,
        required this.userMode,
        required this.deviceType,
        required this.otpCreatedAt,
        required this.emailVerifiedAt,
        required this.phoneNumberVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.userProfile,
        required this.userJobProfile,
    });

    final String? uuid;
    final String? username;
    final String? email;
    final dynamic phoneCode;
    final dynamic phoneNumber;
    final String? balance;
    final String? status;
    final String? userType;
    final String? userMode;
    final dynamic deviceType;
    final dynamic otpCreatedAt;
    final DateTime? emailVerifiedAt;
    final dynamic phoneNumberVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final UserProfile? userProfile;
    final UserJobProfile? userJobProfile;

    factory UserClass.fromJson(Map<String, dynamic> json){
        return UserClass(
            uuid: json["uuid"],
            username: json["username"],
            email: json["email"],
            phoneCode: json["phone_code"],
            phoneNumber: json["phone_number"],
            balance: json["balance"],
            status: json["status"],
            userType: json["user_type"],
            userMode: json["user_mode"],
            deviceType: json["device_type"],
            otpCreatedAt: json["OTP_created_at"],
            emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
            phoneNumberVerifiedAt: json["phone_number_verified_at"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            userProfile: json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]),
            userJobProfile: json["user_job_profile"] == null ? null : UserJobProfile.fromJson(json["user_job_profile"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "username": username,
        "email": email,
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "balance": balance,
        "status": status,
        "user_type": userType,
        "user_mode": userMode,
        "device_type": deviceType,
        "OTP_created_at": otpCreatedAt,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "phone_number_verified_at": phoneNumberVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_profile": userProfile?.toJson(),
        "user_job_profile": userJobProfile?.toJson(),
    };

    @override
    List<Object?> get props => [
        uuid, username, email, phoneCode, phoneNumber, balance, status, userType, userMode, deviceType, otpCreatedAt, emailVerifiedAt, phoneNumberVerifiedAt, createdAt, updatedAt, userProfile, userJobProfile, ];
}

class UserJobProfile extends Equatable {
    UserJobProfile({
        required this.userUuid,
        required this.headline,
        required this.industry,
        required this.website,
        required this.resumeCv,
        required this.coverLetter,
        required this.yearsOfExperience,
        required this.experienceLevel,
        required this.education,
        required this.experience,
        required this.projects,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? userUuid;
    final dynamic headline;
    final dynamic industry;
    final dynamic website;
    final dynamic resumeCv;
    final dynamic coverLetter;
    final dynamic yearsOfExperience;
    final dynamic experienceLevel;
    final dynamic education;
    final dynamic experience;
    final dynamic projects;
    final dynamic createdAt;
    final dynamic updatedAt;

    factory UserJobProfile.fromJson(Map<String, dynamic> json){
        return UserJobProfile(
            userUuid: json["user_uuid"],
            headline: json["headline"],
            industry: json["industry"],
            website: json["website"],
            resumeCv: json["resume_cv"],
            coverLetter: json["cover_letter"],
            yearsOfExperience: json["years_of_experience"],
            experienceLevel: json["experience_level"],
            education: json["education"],
            experience: json["experience"],
            projects: json["projects"],
            createdAt: json["created_at"],
            updatedAt: json["updated_at"],
        );
    }

    Map<String, dynamic> toJson() => {
        "user_uuid": userUuid,
        "headline": headline,
        "industry": industry,
        "website": website,
        "resume_cv": resumeCv,
        "cover_letter": coverLetter,
        "years_of_experience": yearsOfExperience,
        "experience_level": experienceLevel,
        "education": education,
        "experience": experience,
        "projects": projects,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };

    @override
    List<Object?> get props => [
        userUuid, headline, industry, website, resumeCv, coverLetter, yearsOfExperience, experienceLevel, education, experience, projects, createdAt, updatedAt, ];
}

class UserProfile extends Equatable {
    UserProfile({
        required this.userUuid,
        required this.firstName,
        required this.lastName,
        required this.avatar,
        required this.biography,
        required this.country,
        required this.city,
        required this.town,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? userUuid;
    final String? firstName;
    final String? lastName;
    final String? avatar;
    final String? biography;
    final dynamic country;
    final dynamic city;
    final dynamic town;
    final dynamic createdAt;
    final dynamic updatedAt;

    factory UserProfile.fromJson(Map<String, dynamic> json){
        return UserProfile(
            userUuid: json["user_uuid"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            avatar: json["avatar"],
            biography: json["biography"],
            country: json["country"],
            city: json["city"],
            town: json["town"],
            createdAt: json["created_at"],
            updatedAt: json["updated_at"],
        );
    }

    Map<String, dynamic> toJson() => {
        "user_uuid": userUuid,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "biography": biography,
        "country": country,
        "city": city,
        "town": town,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };

    @override
    List<Object?> get props => [
        userUuid, firstName, lastName, avatar, biography, country, city, town, createdAt, updatedAt, ];
}

