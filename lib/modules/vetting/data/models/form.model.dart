import 'package:equatable/equatable.dart';

class FormEntity extends Equatable {
  FormEntity({
    required this.title,
    required this.multiResponse,
    required this.description,
    required this.userUuid,
    required this.uuid,
    required this.slug,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String? title;
  final dynamic? multiResponse;
  final String? description;
  final String? userUuid;
  final String? uuid;
  final String? slug;
  final String? status;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory FormEntity.fromJson(Map<String, dynamic> json){
    return FormEntity(
      title: json["title"],
      multiResponse: json["multi_response"],
      description: json["description"],
      userUuid: json["user_uuid"],
      uuid: json["uuid"],
      slug: json["slug"],
      status: json["status"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

  @override
  List<Object?> get props => [
    title, multiResponse, description, userUuid, uuid, slug, status, updatedAt, createdAt, id, ];
}
