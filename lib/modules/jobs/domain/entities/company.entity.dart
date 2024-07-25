import 'package:equatable/equatable.dart';

class Company extends Equatable {
  Company({
    required this.uuid,
    required this.userUuid,
    required this.name,
    required this.industry,
    required this.location,
    required this.email,
    required this.contact,
    required this.website,
    required this.logo,
    required this.description,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? uuid;
  final String? userUuid;
  final String? name;
  final String? industry;
  final String? location;
  final String? email;
  final String? contact;
  final String? website;
  final String? logo;
  final String? description;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      uuid: json["uuid"],
      userUuid: json["user_uuid"],
      name: json["name"],
      industry: json["industry"],
      location: json["location"],
      email: json["email"],
      contact: json["contact"],
      website: json["website"],
      logo: json["logo"],
      description: json["description"],
      metadata: json["metadata"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  @override
  List<Object?> get props => [
    uuid, userUuid, name, industry, location, email, contact, website, logo, description, metadata, createdAt, updatedAt, ];
}
