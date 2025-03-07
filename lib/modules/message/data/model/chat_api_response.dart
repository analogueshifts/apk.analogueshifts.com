class ChatApiResponse {
  final int? status;
  final bool? success;
  final String? message;
  final List<ChatPagination>? data;

  ChatApiResponse({this.status, this.success, this.message, this.data});

  factory ChatApiResponse.fromJson(Map<String, dynamic> json) {
    List<ChatPagination>? dataList;
    final dynamic rawData = json['data'];
    if (rawData is List) {
      dataList = rawData
          .map((e) => ChatPagination.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      // If data is a Map, wrap it in a list.
      dataList = [ChatPagination.fromJson(rawData)];
    }
    return ChatApiResponse(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class ChatPagination {
  final int? currentPage;
  final List<Chat>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<ChatLink>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  ChatPagination({
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

  factory ChatPagination.fromJson(Map<String, dynamic> json) {
    return ChatPagination(
      currentPage: json['current_page'] as int?,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => Chat.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: json['links'] != null
          ? (json['links'] as List)
              .map((e) => ChatLink.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] is int
          ? json['per_page'] as int?
          : int.tryParse(json['per_page'].toString()),
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
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

class Chat {
   String? uuid;
  final String? type;
  final String? createdAt;
  final String? updatedAt;
   List<ChatMember>? members;
   List<ChatMessage>? messages;

  Chat({
    this.uuid,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.members,
    this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      uuid: json['uuid'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      members: json['members'] != null
          ? (json['members'] as List)
              .map((e) => ChatMember.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'members': members?.map((e) => e.toJson()).toList(),
      'messages': messages?.map((e) => e.toJson()).toList(),
    };
  }
}

class ChatMember {
  final String? uuid;
  final String? chatUuid;
  final String? userUuid;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  ChatMember({
    this.uuid,
    this.chatUuid,
    this.userUuid,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory ChatMember.fromJson(Map<String, dynamic> json) {
    return ChatMember(
      uuid: json['uuid'] as String?,
      chatUuid: json['chat_uuid'] as String?,
      userUuid: json['user_uuid'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'chat_uuid': chatUuid,
      'user_uuid': userUuid,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
    };
  }
}



class ChatMessage {
  final String? uuid;
  final String? chatUuid;
  final String? userUuid;
  final String? message;
  final String? mediaFile;
  final String? refUuid;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  ChatMessage({
    this.uuid,
    this.chatUuid,
    this.userUuid,
    this.message,
    this.mediaFile,
    this.refUuid,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      uuid: json['uuid'] as String?,
      chatUuid: json['chat_uuid'] as String?,
      userUuid: json['user_uuid'] as String?,
      message: json['message'] as String?,
      mediaFile: json['media_file'] as String?,
      refUuid: json['ref_uuid'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'chat_uuid': chatUuid,
      'user_uuid': userUuid,
      'message': message,
      'media_file': mediaFile,
      'ref_uuid': refUuid,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class ChatLink {
  final String? url;
  final String? label;
  final bool? active;

  ChatLink({
    this.url,
    this.label,
    this.active,
  });

  factory ChatLink.fromJson(Map<String, dynamic> json) {
    return ChatLink(
      url: json['url'] as String?,
      label: json['label'] as String?,
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

class User {
  final String? uuid;
  final String? username;
  final String? email;
  final String? phoneCode;
  final String? phoneNumber;
  final String? balance;
  final String? status;
  final String? userType;
  final String? userMode;
  final String? deviceType;
  final String? otpCreatedAt;
  final String? emailVerifiedAt;
  final String? phoneNumberVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final UserProfile? userProfile;

  User({
    this.uuid,
    this.username,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.balance,
    this.status,
    this.userType,
    this.userMode,
    this.deviceType,
    this.otpCreatedAt,
    this.emailVerifiedAt,
    this.phoneNumberVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.userProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneCode: json['phone_code'] as String?,
      phoneNumber: json['phone_number'] as String?,
      balance: json['balance'] as String?,
      status: json['status'] as String?,
      userType: json['user_type'] as String?,
      userMode: json['user_mode'] as String?,
      deviceType: json['device_type'] as String?,
      otpCreatedAt: json['OTP_created_at'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      phoneNumberVerifiedAt: json['phone_number_verified_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userProfile: json['user_profile'] != null
          ? UserProfile.fromJson(json['user_profile'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'username': username,
      'email': email,
      'phone_code': phoneCode,
      'phone_number': phoneNumber,
      'balance': balance,
      'status': status,
      'user_type': userType,
      'user_mode': userMode,
      'device_type': deviceType,
      'OTP_created_at': otpCreatedAt,
      'email_verified_at': emailVerifiedAt,
      'phone_number_verified_at': phoneNumberVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_profile': userProfile?.toJson(),
    };
  }
}

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
      userUuid: json['user_uuid'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatar: json['avatar'] as String?,
      biography: json['biography'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      town: json['town'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
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
