import 'package:json_annotation/json_annotation.dart';

part 'notification.model.g.dart';

@JsonSerializable()
class NotificationModel {
    NotificationModel({
        required this.notifications,
    });

    final Notifications? notifications;

    NotificationModel copyWith({
        Notifications? notifications,
    }) {
        return NotificationModel(
            notifications: notifications ?? this.notifications,
        );
    }

    factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

    Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

}

@JsonSerializable()
class Notifications {
    Notifications({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    @JsonKey(name: 'current_page') 
    final int? currentPage;
    final List<Datum>? data;

    @JsonKey(name: 'first_page_url') 
    final String? firstPageUrl;
    final int? from;

    @JsonKey(name: 'last_page') 
    final int? lastPage;

    @JsonKey(name: 'last_page_url') 
    final String? lastPageUrl;
    final List<Link>? links;

    @JsonKey(name: 'next_page_url') 
    final dynamic nextPageUrl;
    final String? path;

    @JsonKey(name: 'per_page') 
    final int? perPage;

    @JsonKey(name: 'prev_page_url') 
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    Notifications copyWith({
        int? currentPage,
        List<Datum>? data,
        String? firstPageUrl,
        int? from,
        int? lastPage,
        String? lastPageUrl,
        List<Link>? links,
        dynamic? nextPageUrl,
        String? path,
        int? perPage,
        dynamic? prevPageUrl,
        int? to,
        int? total,
    }) {
        return Notifications(
            currentPage: currentPage ?? this.currentPage,
            data: data ?? this.data,
            firstPageUrl: firstPageUrl ?? this.firstPageUrl,
            from: from ?? this.from,
            lastPage: lastPage ?? this.lastPage,
            lastPageUrl: lastPageUrl ?? this.lastPageUrl,
            links: links ?? this.links,
            nextPageUrl: nextPageUrl ?? this.nextPageUrl,
            path: path ?? this.path,
            perPage: perPage ?? this.perPage,
            prevPageUrl: prevPageUrl ?? this.prevPageUrl,
            to: to ?? this.to,
            total: total ?? this.total,
        );
    }

    factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);

    Map<String, dynamic> toJson() => _$NotificationsToJson(this);

}

@JsonSerializable()
class Datum {
    Datum({
        required this.id,
        required this.userUuid,
        required this.title,
        required this.message,
        required this.image,
        required this.viewed,
        required this.path,
        required this.source,
        required this.sourceUuid,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;

    @JsonKey(name: 'user_uuid') 
    final String? userUuid;
    final String? title;
    final String? message;
    final dynamic image;
    final String? viewed;
    final String? path;
    final String? source;

    @JsonKey(name: 'source_uuid') 
    final dynamic sourceUuid;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;

    Datum copyWith({
        int? id,
        String? userUuid,
        String? title,
        String? message,
        dynamic? image,
        String? viewed,
        String? path,
        String? source,
        dynamic? sourceUuid,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return Datum(
            id: id ?? this.id,
            userUuid: userUuid ?? this.userUuid,
            title: title ?? this.title,
            message: message ?? this.message,
            image: image ?? this.image,
            viewed: viewed ?? this.viewed,
            path: path ?? this.path,
            source: source ?? this.source,
            sourceUuid: sourceUuid ?? this.sourceUuid,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);

}

@JsonSerializable()
class Link {
    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    final String? url;
    final String? label;
    final bool? active;

    Link copyWith({
        String? url,
        String? label,
        bool? active,
    }) {
        return Link(
            url: url ?? this.url,
            label: label ?? this.label,
            active: active ?? this.active,
        );
    }

    factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

    Map<String, dynamic> toJson() => _$LinkToJson(this);

}
