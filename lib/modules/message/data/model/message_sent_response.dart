import 'package:analogue_shifts_mobile/modules/message/data/model/chat_api_response.dart';

class MessageSentResponse {
  final int? status;
  final bool? success;
  final String? message;
  final MessageSentData? data;

  MessageSentResponse({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory MessageSentResponse.fromJson(Map<String, dynamic> json) {
    return MessageSentResponse(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? MessageSentData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MessageSentData {
  final Chat? chat;
  final ChatMessages? messages;

  MessageSentData({
    this.chat,
    this.messages,
  });

  factory MessageSentData.fromJson(Map<String, dynamic> json) {
    return MessageSentData(
      chat: json['chat'] != null
          ? Chat.fromJson(json['chat'] as Map<String, dynamic>)
          : null,
      messages: json['messages'] != null
          ? ChatMessages.fromJson(json['messages'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Chat {
  final String? uuid;
  final String? type;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Chat({
    this.uuid,
    this.type,
    this.updatedAt,
    this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      uuid: json['uuid'] as String?,
      type: json['type'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }
}

class ChatMessages {
  final int? currentPage;
  final List<ChatMessage>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<dynamic>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  ChatMessages({
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

  factory ChatMessages.fromJson(Map<String, dynamic> json) {
    return ChatMessages(
      currentPage: json['current_page'] as int?,
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: json['links'] as List<dynamic>?,
      nextPageUrl: json['next_page_url'],
      path: json['path'] as String?,
      perPage: json['per_page'] != null
          ? int.tryParse(json['per_page'].toString())
          : null,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }
}
