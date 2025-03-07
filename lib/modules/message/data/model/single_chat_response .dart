class SingleChatResponse {
  final int status;
  final bool success;
  final String message;
  final SingleChatData? data;

  SingleChatResponse({
    required this.status,
    required this.success,
    required this.message,
    this.data,
  });

  factory SingleChatResponse.fromJson(Map<String, dynamic> json) {
    return SingleChatResponse(
      status: json['status'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SingleChatData.fromJson(json['data']) : null,
    );
  }
}

class SingleChatData {
  // The API uses the key "members" for the chat details.
  final ChatDetails? chatDetails;
  final ChatMessages? messages;

  SingleChatData({
    this.chatDetails,
    this.messages,
  });

  factory SingleChatData.fromJson(Map<String, dynamic> json) {
    return SingleChatData(
      chatDetails: json['members'] != null
          ? ChatDetails.fromJson(json['members'])
          : null,
      messages: json['messages'] != null
          ? ChatMessages.fromJson(json['messages'])
          : null,
    );
  }
}

class ChatDetails {
  final String? uuid;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ChatMember>? members;

  ChatDetails({
    this.uuid,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.members,
  });

  factory ChatDetails.fromJson(Map<String, dynamic> json) {
    return ChatDetails(
      uuid: json['uuid'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      members: json['members'] != null
          ? (json['members'] as List<dynamic>)
              .map((e) => ChatMember.fromJson(e))
              .toList()
          : null,
    );
  }
}

class ChatMember {
  final String? uuid;
  final String? chatUuid;
  final String? userUuid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ChatUser? user;

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
      uuid: json['uuid'] ?? '',
      chatUuid: json['chat_uuid'] ?? '',
      userUuid: json['user_uuid'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      user: json['user'] != null ? ChatUser.fromJson(json['user']) : null,
    );
  }
}

class ChatUser {
  final String? uuid;
  final String? username;
  final String? email;
  final String? phoneCode;
  final String? phoneNumber;
  final String? balance;
  final String? status;
  final String? userType;
  final String? userMode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserProfile? userProfile;

  ChatUser({
    this.uuid,
    this.username,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.balance,
    this.status,
    this.userType,
    this.userMode,
    this.createdAt,
    this.updatedAt,
    this.userProfile,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      uuid: json['uuid'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phoneCode: json['phone_code'],
      phoneNumber: json['phone_number'],
      balance: json['balance'] ?? '0',
      status: json['status'] ?? '',
      userType: json['user_type'] ?? '',
      userMode: json['user_mode'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      userProfile: json['user_profile'] != null
          ? UserProfile.fromJson(json['user_profile'])
          : null,
    );
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
      userUuid: json['user_uuid'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'],
      biography: json['biography'],
      country: json['country'],
      city: json['city'],
      town: json['town'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}

class ChatMessages {
  final int? currentPage;
  final List<ChatMessage>? data;
  // Additional pagination fields can be added here if needed.

  ChatMessages({
    this.currentPage,
    this.data,
  });

  factory ChatMessages.fromJson(Map<String, dynamic> json) {
    return ChatMessages(
      currentPage: json['current_page'] ?? 1,
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((e) => ChatMessage.fromJson(e))
              .toList()
          : [],
    );
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
      uuid: json['uuid'] ?? '',
      chatUuid: json['chat_uuid'] ?? '',
      userUuid: json['user_uuid'] ?? '',
      message: json['message'] ?? '',
      mediaFile: json['media_file'],
      refUuid: json['ref_uuid'],
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
