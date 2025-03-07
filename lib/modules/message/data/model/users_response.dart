import 'package:analogue_shifts_mobile/modules/message/data/model/user_search_response.dart';

class AllUserResponse {
  final int? status;
  final bool? success;
  final String? message;
  final AllUserData? data;

  AllUserResponse({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory AllUserResponse.fromJson(Map<String, dynamic> json) {
    return AllUserResponse(
      status: json['status'] is int ? json['status'] : int.tryParse(json['status']?.toString() ?? ''),
      success: json['success'] as bool?,
      message: parseNullableString(json['message']),
      data: json['data'] != null
          ? AllUserData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class AllUserData {
  final String? userMode;
  final UserData? users;

  AllUserData({this.userMode, this.users});

  factory AllUserData.fromJson(Map<String, dynamic> json) {
    return AllUserData(
      userMode: parseNullableString(json['user_mode']),
      users: json['users'] != null
          ? UserData.fromJson(json['users'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_mode': userMode,
      'users': users?.toJson(),
    };
  }
}

class UserData {
  final int? currentPage;
  final List<UserDetail>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  UserData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      currentPage: json['current_page'] is int
          ? json['current_page']
          : int.tryParse(json['current_page']?.toString() ?? ''),
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => UserDetail.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      firstPageUrl: parseNullableString(json['first_page_url']),
      from: json['from'] is int ? json['from'] : int.tryParse(json['from']?.toString() ?? ''),
      lastPage: json['last_page'] is int ? json['last_page'] : int.tryParse(json['last_page']?.toString() ?? ''),
      lastPageUrl: parseNullableString(json['last_page_url']),
      links: json['links'] != null
          ? (json['links'] as List)
              .map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      nextPageUrl: parseNullableString(json['next_page_url']),
      path: parseNullableString(json['path']),
      perPage: json['per_page'] is int ? json['per_page'] : int.tryParse(json['per_page']?.toString() ?? ''),
      prevPageUrl: parseNullableString(json['prev_page_url']),
      to: json['to'] is int ? json['to'] : int.tryParse(json['to']?.toString() ?? ''),
      total: json['total'] is int ? json['total'] : int.tryParse(json['total']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((e) => e.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((e) => e.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

// class UserDetail {
//   final String? uuid;
//   final String? username;
//   final String? email;
//   final String? phoneCode;
//   final String? phoneNumber;
//   final String? balance;
//   final String? status;
//   final String? userType;
//   final String? userMode;
//   final String? deviceType;
//   final String? otpCreatedAt;
//   final String? emailVerifiedAt;
//   final String? phoneNumberVerifiedAt;
//   final String? createdAt;
//   final String? updatedAt;
//   final UserProfile? userProfile;
//   final UserJobProfile? userJobProfile;

//   UserDetail({
//     this.uuid,
//     this.username,
//     this.email,
//     this.phoneCode,
//     this.phoneNumber,
//     this.balance,
//     this.status,
//     this.userType,
//     this.userMode,
//     this.deviceType,
//     this.otpCreatedAt,
//     this.emailVerifiedAt,
//     this.phoneNumberVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.userProfile,
//     this.userJobProfile,
//   });

//   factory UserDetail.fromJson(Map<String, dynamic> json) {
//     return UserDetail(
//       uuid: parseNullableString(json['uuid']),
//       username: parseNullableString(json['username']),
//       email: parseNullableString(json['email']),
//       phoneCode: parseNullableString(json['phone_code']),
//       phoneNumber: parseNullableString(json['phone_number']),
//       balance: parseNullableString(json['balance']),
//       status: parseNullableString(json['status']),
//       userType: parseNullableString(json['user_type']),
//       userMode: parseNullableString(json['user_mode']),
//       deviceType: parseNullableString(json['device_type']),
//       otpCreatedAt: parseNullableString(json['OTP_created_at']),
//       emailVerifiedAt: parseNullableString(json['email_verified_at']),
//       phoneNumberVerifiedAt: parseNullableString(json['phone_number_verified_at']),
//       createdAt: parseNullableString(json['created_at']),
//       updatedAt: parseNullableString(json['updated_at']),
//       userProfile: json['user_profile'] != null
//           ? UserProfile.fromJson(json['user_profile'] as Map<String, dynamic>)
//           : null,
//       userJobProfile: json['user_job_profile'] != null
//           ? UserJobProfile.fromJson(json['user_job_profile'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'uuid': uuid,
//       'username': username,
//       'email': email,
//       'phone_code': phoneCode,
//       'phone_number': phoneNumber,
//       'balance': balance,
//       'status': status,
//       'user_type': userType,
//       'user_mode': userMode,
//       'device_type': deviceType,
//       'OTP_created_at': otpCreatedAt,
//       'email_verified_at': emailVerifiedAt,
//       'phone_number_verified_at': phoneNumberVerifiedAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'user_profile': userProfile?.toJson(),
//       'user_job_profile': userJobProfile?.toJson(),
//     };
//   }
// }

class UserProfile {
  final String? userUuid;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? biography;
  final String? country;
  final String? city;
  final String? town;
  final String? createdAt;
  final String? updatedAt;

  UserProfile({
    this.userUuid,
    this.firstName,
    this.lastName,
    this.avatar,
    this.biography,
    this.country,
    this.city,
    this.town,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userUuid: parseNullableString(json['user_uuid']),
      firstName: parseNullableString(json['first_name']),
      lastName: parseNullableString(json['last_name']),
      avatar: parseNullableString(json['avatar']),
      biography: parseNullableString(json['biography']),
      country: parseNullableString(json['country']),
      city: parseNullableString(json['city']),
      town: parseNullableString(json['town']),
      createdAt: parseNullableString(json['created_at']),
      updatedAt: parseNullableString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_uuid': userUuid,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'biography': biography,
      'country': country,
      'city': city,
      'town': town,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class UserJobProfile {
  final String? userUuid;
  final String? headline;
  final String? industry;
  final String? website;
  final String? resumeCv;
  final String? coverLetter;
  final String? yearsOfExperience;
  final String? experienceLevel;
  final String? education;
  final String? experience;
  final String? projects;
  final String? jobType;
  final String? salary;
  final String? locations;
  final String? socials;
  final String? createdAt;
  final String? updatedAt;

  UserJobProfile({
    this.userUuid,
    this.headline,
    this.industry,
    this.website,
    this.resumeCv,
    this.coverLetter,
    this.yearsOfExperience,
    this.experienceLevel,
    this.education,
    this.experience,
    this.projects,
    this.jobType,
    this.salary,
    this.locations,
    this.socials,
    this.createdAt,
    this.updatedAt,
  });

  factory UserJobProfile.fromJson(Map<String, dynamic> json) {
    return UserJobProfile(
      userUuid: parseNullableString(json['user_uuid']),
      headline: parseNullableString(json['headline']),
      industry: parseNullableString(json['industry']),
      website: parseNullableString(json['website']),
      resumeCv: parseNullableString(json['resume_cv']),
      coverLetter: parseNullableString(json['cover_letter']),
      yearsOfExperience: json['years_of_experience']?.toString(),
      experienceLevel: json['experience_level']?.toString(),
      education: parseNullableString(json['education']),
      experience: parseNullableString(json['experience']),
      projects: parseNullableString(json['projects']),
      jobType: parseNullableString(json['job_type']),
      salary: parseNullableString(json['salary']),
      locations: parseNullableString(json['locations']),
      socials: parseNullableString(json['socials']),
      createdAt: parseNullableString(json['created_at']),
      updatedAt: parseNullableString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_uuid': userUuid,
      'headline': headline,
      'industry': industry,
      'website': website,
      'resume_cv': resumeCv,
      'cover_letter': coverLetter,
      'years_of_experience': yearsOfExperience,
      'experience_level': experienceLevel,
      'education': education,
      'experience': experience,
      'projects': projects,
      'job_type': jobType,
      'salary': salary,
      'locations': locations,
      'socials': socials,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: parseNullableString(json['url']),
      label: parseNullableString(json['label']),
      active: json['active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

String? parseNullableString(dynamic value) {
  if (value is String) {
    return value;
  }
  return null;
}
