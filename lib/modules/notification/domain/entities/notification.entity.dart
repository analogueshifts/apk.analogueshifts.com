import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
    NotificationEntity({
        required this.notifications,
    });

    final Notifications? notifications;

    NotificationEntity copyWith({
        Notifications? notifications,
    }) {
        return NotificationEntity(
            notifications: notifications ?? this.notifications,
        );
    }

    factory NotificationEntity.fromJson(Map<String, dynamic> json){ 
        return NotificationEntity(
            notifications: json["notifications"] == null ? null : Notifications.fromJson(json["notifications"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "notifications": notifications?.toJson(),
    };

    @override
    List<Object?> get props => [
    notifications, ];
}

class Notifications extends Equatable {
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

    final int? currentPage;
    final List<Datum> data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link> links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
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

    factory Notifications.fromJson(Map<String, dynamic> json){ 
        return Notifications(
            currentPage: json["current_page"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            firstPageUrl: json["first_page_url"],
            from: json["from"],
            lastPage: json["last_page"],
            lastPageUrl: json["last_page_url"],
            links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
            nextPageUrl: json["next_page_url"],
            path: json["path"],
            perPage: json["per_page"],
            prevPageUrl: json["prev_page_url"],
            to: json["to"],
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data.map((x) => x?.toJson()).toList(),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links.map((x) => x?.toJson()).toList(),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };

    @override
    List<Object?> get props => [
    currentPage, data, firstPageUrl, from, lastPage, lastPageUrl, links, nextPageUrl, path, perPage, prevPageUrl, to, total, ];
}

class Datum extends Equatable {
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
    final String? userUuid;
    final String? title;
    final String? message;
    final dynamic image;
    final String? viewed;
    final String? path;
    final String? source;
    final dynamic sourceUuid;
    final DateTime? createdAt;
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

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            userUuid: json["user_uuid"],
            title: json["title"],
            message: json["message"],
            image: json["image"],
            viewed: json["viewed"],
            path: json["path"],
            source: json["source"],
            sourceUuid: json["source_uuid"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_uuid": userUuid,
        "title": title,
        "message": message,
        "image": image,
        "viewed": viewed,
        "path": path,
        "source": source,
        "source_uuid": sourceUuid,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
    id, userUuid, title, message, image, viewed, path, source, sourceUuid, createdAt, updatedAt, ];
}

class Link extends Equatable {
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

    factory Link.fromJson(Map<String, dynamic> json){ 
        return Link(
            url: json["url"],
            label: json["label"],
            active: json["active"],
        );
    }

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };

    @override
    List<Object?> get props => [
    url, label, active, ];
}
