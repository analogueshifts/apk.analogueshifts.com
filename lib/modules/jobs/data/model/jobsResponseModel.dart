import 'package:json_annotation/json_annotation.dart';

part 'jobsResponseModel.g.dart';

@JsonSerializable()
class JobResponseModel {
  JobResponseModel({
    required this.status,
    required this.success,
    required this.data,
  });

  final int? status;
  final bool? success;
  final Data? data;

  JobResponseModel copyWith({
    int? status,
    bool? success,
    Data? data,
  }) {
    return JobResponseModel(
      status: status ?? this.status,
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  factory JobResponseModel.fromJson(Map<String, dynamic> json) => _$JobResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobResponseModelToJson(this);

}

@JsonSerializable()
class Data {
  Data({
    required this.jobs,
  });

  final Jobs? jobs;

  Data copyWith({
    Jobs? jobs,
  }) {
    return Data(
      jobs: jobs ?? this.jobs,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

@JsonSerializable()
class Jobs {
  Jobs({
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

  Jobs copyWith({
    int? currentPage,
    List<Datum>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic? prevPageUrl,
    int? to,
    int? total,
  }) {
    return Jobs(
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

  factory Jobs.fromJson(Map<String, dynamic> json) => _$JobsFromJson(json);

  Map<String, dynamic> toJson() => _$JobsToJson(this);

}

@JsonSerializable()
class Datum {
  Datum({
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

  Datum copyWith({
    int? id,
    String? uuid,
    String? slug,
    String? userUuid,
    String? title,
    String? description,
    Identifier? identifier,
    HiringOrganization? hiringOrganization,
    List<dynamic>? applicantLocationRequirements,
    BaseSalary? baseSalary,
    String? directApply,
    dynamic? employmentType,
    JobLocation? jobLocation,
    dynamic? jobLocationType,
    DateTime? validThrough,
    String? status,
    String? apply,
    dynamic? alts,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Datum(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      slug: slug ?? this.slug,
      userUuid: userUuid ?? this.userUuid,
      title: title ?? this.title,
      description: description ?? this.description,
      identifier: identifier ?? this.identifier,
      hiringOrganization: hiringOrganization ?? this.hiringOrganization,
      applicantLocationRequirements: applicantLocationRequirements ?? this.applicantLocationRequirements,
      baseSalary: baseSalary ?? this.baseSalary,
      directApply: directApply ?? this.directApply,
      employmentType: employmentType ?? this.employmentType,
      jobLocation: jobLocation ?? this.jobLocation,
      jobLocationType: jobLocationType ?? this.jobLocationType,
      validThrough: validThrough ?? this.validThrough,
      status: status ?? this.status,
      apply: apply ?? this.apply,
      alts: alts ?? this.alts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

}

@JsonSerializable()
class BaseSalary {
  BaseSalary({
    required this.type,
    required this.value,
  });

  @JsonKey(name: '@type')
  final String? type;
  final Value? value;

  BaseSalary copyWith({
    String? type,
    Value? value,
  }) {
    return BaseSalary(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  factory BaseSalary.fromJson(Map<String, dynamic> json) => _$BaseSalaryFromJson(json);

  Map<String, dynamic> toJson() => _$BaseSalaryToJson(this);

}

@JsonSerializable()
class Value {
  Value({
    required this.type,
    required this.value,
  });

  @JsonKey(name: '@type')
  final String? type;
  final String? value;

  Value copyWith({
    String? type,
    String? value,
  }) {
    return Value(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

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

  HiringOrganization copyWith({
    String? type,
    String? name,
    String? sameAs,
    dynamic? logo,
  }) {
    return HiringOrganization(
      type: type ?? this.type,
      name: name ?? this.name,
      sameAs: sameAs ?? this.sameAs,
      logo: logo ?? this.logo,
    );
  }

  factory HiringOrganization.fromJson(Map<String, dynamic> json) => _$HiringOrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$HiringOrganizationToJson(this);

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

  Identifier copyWith({
    String? type,
    String? name,
    dynamic? value,
  }) {
    return Identifier(
      type: type ?? this.type,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  factory Identifier.fromJson(Map<String, dynamic> json) => _$IdentifierFromJson(json);

  Map<String, dynamic> toJson() => _$IdentifierToJson(this);

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

  JobLocation copyWith({
    String? type,
    Address? address,
  }) {
    return JobLocation(
      type: type ?? this.type,
      address: address ?? this.address,
    );
  }

  factory JobLocation.fromJson(Map<String, dynamic> json) => _$JobLocationFromJson(json);

  Map<String, dynamic> toJson() => _$JobLocationToJson(this);

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
  final dynamic addressLocality;
  final dynamic addressRegion;
  final dynamic postalCode;
  final dynamic addressCountry;

  Address copyWith({
    String? type,
    dynamic? streetAddress,
    dynamic? addressLocality,
    dynamic? addressRegion,
    dynamic? postalCode,
    dynamic? addressCountry,
  }) {
    return Address(
      type: type ?? this.type,
      streetAddress: streetAddress ?? this.streetAddress,
      addressLocality: addressLocality ?? this.addressLocality,
      addressRegion: addressRegion ?? this.addressRegion,
      postalCode: postalCode ?? this.postalCode,
      addressCountry: addressCountry ?? this.addressCountry,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

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

