import 'package:json_annotation/json_annotation.dart';

part 'jobsResponseModel.g.dart';

@JsonSerializable()
class JobResponseModel {
  JobResponseModel({
    required this.jobs,
  });

  final List<Job>? jobs;

  factory JobResponseModel.fromJson(Map<String, dynamic> json) => _$JobResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobResponseModelToJson(this);

  @override
  String toString(){
    return "$jobs, ";
  }
}

@JsonSerializable()
class Job {
  Job({
    required this.id,
    required this.slug,
    required this.userId,
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
  final String? slug;

  @JsonKey(name: 'user_id')
  final String? userId;
  final String? title;
  final String? description;
  final Identifier? identifier;
  final HiringOrganization? hiringOrganization;
  final List<ApplicantLocationRequirement>? applicantLocationRequirements;
  final BaseSalary? baseSalary;
  final String? directApply;
  final String? employmentType;
  final JobLocation? jobLocation;
  final String? jobLocationType;
  final DateTime? validThrough;
  final String? status;
  final String? apply;
  final dynamic alts;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);

  @override
  String toString(){
    return "$id, $slug, $userId, $title, $description, $identifier, $hiringOrganization, $applicantLocationRequirements, $baseSalary, $directApply, $employmentType, $jobLocation, $jobLocationType, $validThrough, $status, $apply, $alts, $createdAt, $updatedAt, ";
  }
}

@JsonSerializable()
class ApplicantLocationRequirement {
  ApplicantLocationRequirement({
    required this.type,
    required this.name,
  });

  @JsonKey(name: '@type')
  final String? type;
  final String? name;

  factory ApplicantLocationRequirement.fromJson(Map<String, dynamic> json) => _$ApplicantLocationRequirementFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantLocationRequirementToJson(this);

  @override
  String toString(){
    return "$type, $name, ";
  }
}

@JsonSerializable()
class BaseSalary {
  BaseSalary({
    required this.type,
    required this.value,
    required this.currency,
  });

  @JsonKey(name: '@type')
  final String? type;
  final Value? value;
  final String? currency;

  factory BaseSalary.fromJson(Map<String, dynamic> json) => _$BaseSalaryFromJson(json);

  Map<String, dynamic> toJson() => _$BaseSalaryToJson(this);

  @override
  String toString(){
    return "$type, $value, $currency, ";
  }
}

@JsonSerializable()
class Value {
  Value({
    required this.type,
    required this.value,
    required this.unitText,
  });

  @JsonKey(name: '@type')
  final String? type;
  final String? value;
  final String? unitText;

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  @override
  String toString(){
    return "$type, $value, $unitText, ";
  }
}

@JsonSerializable()
class HiringOrganization {
  HiringOrganization({
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

  Map<String, dynamic> toJson() => _$HiringOrganizationToJson(this);

  @override
  String toString(){
    return "$type, $name, $sameAs, $logo, ";
  }
}

@JsonSerializable()
class Identifier {
  Identifier({
    required this.type,
    required this.name,
    required this.value,
  });

  @JsonKey(name: '@type')
  final String? type;
  final String? name;
  final dynamic value;

  factory Identifier.fromJson(Map<String, dynamic> json) => _$IdentifierFromJson(json);

  Map<String, dynamic> toJson() => _$IdentifierToJson(this);

  @override
  String toString(){
    return "$type, $name, $value, ";
  }
}

@JsonSerializable()
class JobLocation {
  JobLocation({
    required this.type,
    required this.address,
  });

  @JsonKey(name: '@type')
  final String? type;
  final Address? address;

  factory JobLocation.fromJson(Map<String, dynamic> json) => _$JobLocationFromJson(json);

  Map<String, dynamic> toJson() => _$JobLocationToJson(this);

  @override
  String toString(){
    return "$type, $address, ";
  }
}

@JsonSerializable()
class Address {
  Address({
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
  final String? addressLocality;
  final dynamic addressRegion;
  final dynamic postalCode;
  final String? addressCountry;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString(){
    return "$type, $streetAddress, $addressLocality, $addressRegion, $postalCode, $addressCountry, ";
  }
}
