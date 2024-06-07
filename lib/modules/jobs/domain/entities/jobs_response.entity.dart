import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jobs_response.entity.g.dart';

@JsonSerializable(createToJson: false)
class JobResponseEntity extends Equatable {
  const JobResponseEntity({
    required this.status,
    required this.success,
    required this.data,
  });

  final int? status;
  final bool? success;
  final Data? data;

  factory JobResponseEntity.fromJson(Map<String, dynamic> json) => _$JobResponseEntityFromJson(json);

  @override
  List<Object?> get props => [
    status, success, data, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
  const Data({
    required this.jobs,
  });

  final Jobs? jobs;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  @override
  List<Object?> get props => [
    jobs, ];
}

@JsonSerializable(createToJson: false)
class Jobs extends Equatable {
  const Jobs({
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
  final String? nextPageUrl;
  final String? path;

  @JsonKey(name: 'per_page')
  final int? perPage;

  @JsonKey(name: 'prev_page_url')
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory Jobs.fromJson(Map<String, dynamic> json) => _$JobsFromJson(json);

  @override
  List<Object?> get props => [
    currentPage, data, firstPageUrl, from, lastPage, lastPageUrl, links, nextPageUrl, path, perPage, prevPageUrl, to, total, ];
}

@JsonSerializable(createToJson: false)
class Datum extends Equatable {
  const Datum({
    required this.id,
    required this.uuid,
    required this.slug,
    required this.userUuid,
    required this.title,
    required this.description,
    required this.identifier,
    required this.hiringOrganization,
    required this.applicantLocationRequirements,
    required this.baseSalary,
    required this.directApply,
    required this.employmentType,
    required this.jobLocation,
    required this.jobLocationType,
    required this.validThrough,
    required this.status,
    required this.apply,
    required this.alts,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? uuid;
  final String? slug;

  @JsonKey(name: 'user_uuid')
  final String? userUuid;
  final String? title;
  final String? description;
  final Identifier? identifier;
  final HiringOrganization? hiringOrganization;
  final List<dynamic>? applicantLocationRequirements;
  final BaseSalary? baseSalary;
  final String? directApply;
  final dynamic employmentType;
  final JobLocation? jobLocation;
  final dynamic jobLocationType;
  final DateTime? validThrough;
  final String? status;
  final String? apply;
  final dynamic alts;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  @override
  List<Object?> get props => [
    id, uuid, slug, userUuid, title, description, identifier, hiringOrganization, applicantLocationRequirements, baseSalary, directApply, employmentType, jobLocation, jobLocationType, validThrough, status, apply, alts, createdAt, updatedAt, ];
}

@JsonSerializable(createToJson: false)
class BaseSalary extends Equatable {
  const BaseSalary({
    required this.type,
    required this.value,
  });

  @JsonKey(name: '@type')
  final String? type;
  final Value? value;

  factory BaseSalary.fromJson(Map<String, dynamic> json) => _$BaseSalaryFromJson(json);

  @override
  List<Object?> get props => [
    type, value, ];
}

@JsonSerializable(createToJson: false)
class Value extends Equatable {
  const Value({
    required this.type,
    required this.value,
  });

  @JsonKey(name: '@type')
  final String? type;
  final String? value;

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  @override
  List<Object?> get props => [
    type, value, ];
}

@JsonSerializable(createToJson: false)
class HiringOrganization extends Equatable {
  const HiringOrganization({
    required this.type,
    required this.name,
    required this.sameAs,
    required this.logo,
  });

  @JsonKey(name: '@type')
  final String? type;
  final String? name;
  final String? sameAs;
  final dynamic logo;

  factory HiringOrganization.fromJson(Map<String, dynamic> json) => _$HiringOrganizationFromJson(json);

  @override
  List<Object?> get props => [
    type, name, sameAs, logo, ];
}

@JsonSerializable(createToJson: false)
class Identifier extends Equatable {
  const Identifier({
    required this.type,
    required this.name,
    required this.value,
  });

  @JsonKey(name: '@type')
  final String? type;
  final String? name;
  final dynamic value;

  factory Identifier.fromJson(Map<String, dynamic> json) => _$IdentifierFromJson(json);

  @override
  List<Object?> get props => [
    type, name, value, ];
}

@JsonSerializable(createToJson: false)
class JobLocation extends Equatable {
  const JobLocation({
    required this.type,
    required this.address,
  });

  @JsonKey(name: '@type')
  final String? type;
  final Address? address;

  factory JobLocation.fromJson(Map<String, dynamic> json) => _$JobLocationFromJson(json);

  @override
  List<Object?> get props => [
    type, address, ];
}

@JsonSerializable(createToJson: false)
class Address extends Equatable {
  const Address({
    required this.type,
    required this.streetAddress,
    required this.addressLocality,
    required this.addressRegion,
    required this.postalCode,
    required this.addressCountry,
  });

  @JsonKey(name: '@type')
  final String? type;
  final dynamic streetAddress;
  final dynamic addressLocality;
  final dynamic addressRegion;
  final dynamic postalCode;
  final dynamic addressCountry;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  @override
  List<Object?> get props => [
    type, streetAddress, addressLocality, addressRegion, postalCode, addressCountry, ];
}

@JsonSerializable(createToJson: false)
class Link extends Equatable {
  const Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  List<Object?> get props => [
    url, label, active, ];
}
