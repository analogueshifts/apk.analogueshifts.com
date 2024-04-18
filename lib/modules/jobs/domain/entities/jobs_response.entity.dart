import 'package:equatable/equatable.dart';

class JobResponse extends Equatable {
  JobResponse({
    required this.jobs,
  });

  final List<Job> jobs;

  factory JobResponse.fromJson(Map<String, dynamic> json){
    return JobResponse(
      jobs: json["jobs"] == null ? [] : List<Job>.from(json["jobs"]!.map((x) => Job.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "jobs": jobs.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    jobs, ];
}

class Job extends Equatable {
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
  final String? userId;
  final String? title;
  final String? description;
  final Identifier? identifier;
  final HiringOrganization? hiringOrganization;
  final List<ApplicantLocationRequirement> applicantLocationRequirements;
  final BaseSalary? baseSalary;
  final String? directApply;
  final String? employmentType;
  final JobLocation? jobLocation;
  final String? jobLocationType;
  final DateTime? validThrough;
  final String? status;
  final String? apply;
  final dynamic alts;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Job.fromJson(Map<String, dynamic> json){
    return Job(
      id: json["id"],
      slug: json["slug"],
      userId: json["user_id"],
      title: json["title"],
      description: json["description"],
      identifier: json["identifier"] == null ? null : Identifier.fromJson(json["identifier"]),
      hiringOrganization: json["hiringOrganization"] == null ? null : HiringOrganization.fromJson(json["hiringOrganization"]),
      applicantLocationRequirements: json["applicantLocationRequirements"] == null ? [] : List<ApplicantLocationRequirement>.from(json["applicantLocationRequirements"]!.map((x) => ApplicantLocationRequirement.fromJson(x))),
      baseSalary: json["baseSalary"] == null ? null : BaseSalary.fromJson(json["baseSalary"]),
      directApply: json["directApply"],
      employmentType: json["employmentType"],
      jobLocation: json["jobLocation"] == null ? null : JobLocation.fromJson(json["jobLocation"]),
      jobLocationType: json["jobLocationType"],
      validThrough: DateTime.tryParse(json["validThrough"] ?? ""),
      status: json["status"],
      apply: json["apply"],
      alts: json["alts"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "user_id": userId,
    "title": title,
    "description": description,
    "identifier": identifier?.toJson(),
    "hiringOrganization": hiringOrganization?.toJson(),
    "applicantLocationRequirements": applicantLocationRequirements.map((x) => x.toJson()).toList(),
    "baseSalary": baseSalary?.toJson(),
    "directApply": directApply,
    "employmentType": employmentType,
    "jobLocation": jobLocation?.toJson(),
    "jobLocationType": jobLocationType,
    "validThrough": validThrough,
    "status": status,
    "apply": apply,
    "alts": alts,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id, slug, userId, title, description, identifier, hiringOrganization, applicantLocationRequirements, baseSalary, directApply, employmentType, jobLocation, jobLocationType, validThrough, status, apply, alts, createdAt, updatedAt, ];
}

class ApplicantLocationRequirement extends Equatable {
  ApplicantLocationRequirement({
    required this.type,
    required this.name,
  });

  final String? type;
  final String? name;

  factory ApplicantLocationRequirement.fromJson(Map<String, dynamic> json){
    return ApplicantLocationRequirement(
      type: json["@type"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "name": name,
  };

  @override
  List<Object?> get props => [
    type, name, ];
}

class BaseSalary extends Equatable {
  BaseSalary({
    required this.type,
    required this.value,
    required this.currency,
  });

  final String? type;
  final Value? value;
  final String? currency;

  factory BaseSalary.fromJson(Map<String, dynamic> json){
    return BaseSalary(
      type: json["@type"],
      value: json["value"] == null ? null : Value.fromJson(json["value"]),
      currency: json["currency"],
    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "value": value?.toJson(),
    "currency": currency,
  };

  @override
  List<Object?> get props => [
    type, value, currency, ];
}

class Value extends Equatable {
  Value({
    required this.type,
    required this.value,
    required this.unitText,
  });

  final String? type;
  final String? value;
  final String? unitText;

  factory Value.fromJson(Map<String, dynamic> json){
    return Value(
      type: json["@type"],
      value: json["value"],
      unitText: json["unitText"],
    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "value": value,
    "unitText": unitText,
  };

  @override
  List<Object?> get props => [
    type, value, unitText, ];
}

class HiringOrganization extends Equatable {
  HiringOrganization({
    required this.type,
    required this.name,
    required this.sameAs,
    required this.logo,
  });

  final String? type;
  final String? name;
  final String? sameAs;
  final dynamic logo;

  factory HiringOrganization.fromJson(Map<String, dynamic> json){
    return HiringOrganization(
      type: json["@type"],
      name: json["name"],
      sameAs: json["sameAs"],
      logo: json["logo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "name": name,
    "sameAs": sameAs,
    "logo": logo,
  };

  @override
  List<Object?> get props => [
    type, name, sameAs, logo, ];
}

class Identifier extends Equatable {
  Identifier({
    required this.type,
    required this.name,
    required this.value,
  });

  final String? type;
  final String? name;
  final dynamic value;

  factory Identifier.fromJson(Map<String, dynamic> json){
    return Identifier(
      type: json["@type"],
      name: json["name"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "name": name,
    "value": value,
  };

  @override
  List<Object?> get props => [
    type, name, value, ];
}

class JobLocation extends Equatable {
  JobLocation({
    required this.type,
    required this.address,
  });

  final String? type;
  final Address? address;

  factory JobLocation.fromJson(Map<String, dynamic> json){
    return JobLocation(
      type: json["@type"],
      address: json["address"] == null ? null : Address.fromJson(json["address"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "address": address?.toJson(),
  };

  @override
  List<Object?> get props => [
    type, address, ];
}

class Address extends Equatable {
  Address({
    required this.type,
    required this.streetAddress,
    required this.addressLocality,
    required this.addressRegion,
    required this.postalCode,
    required this.addressCountry,
  });

  final String? type;
  final dynamic streetAddress;
  final String? addressLocality;
  final dynamic addressRegion;
  final dynamic postalCode;
  final String? addressCountry;

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
      type: json["@type"],
      streetAddress: json["streetAddress"],
      addressLocality: json["addressLocality"],
      addressRegion: json["addressRegion"],
      postalCode: json["postalCode"],
      addressCountry: json["addressCountry"],
    );
  }

  Map<String, dynamic> toJson() => {
    "@type": type,
    "streetAddress": streetAddress,
    "addressLocality": addressLocality,
    "addressRegion": addressRegion,
    "postalCode": postalCode,
    "addressCountry": addressCountry,
  };

  @override
  List<Object?> get props => [
    type, streetAddress, addressLocality, addressRegion, postalCode, addressCountry, ];
}
