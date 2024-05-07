// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_response.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobResponseEntity _$JobResponseEntityFromJson(Map<String, dynamic> json) =>
    JobResponseEntity(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      jobs: json['jobs'] == null
          ? null
          : Jobs.fromJson(json['jobs'] as Map<String, dynamic>),
    );

Jobs _$JobsFromJson(Map<String, dynamic> json) => Jobs(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] as int?,
      total: json['total'] as int?,
    );

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      slug: json['slug'] as String?,
      userUuid: json['user_uuid'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      identifier: json['identifier'] == null
          ? null
          : Identifier.fromJson(json['identifier'] as Map<String, dynamic>),
      hiringOrganization: json['hiringOrganization'] == null
          ? null
          : HiringOrganization.fromJson(
              json['hiringOrganization'] as Map<String, dynamic>),
      applicantLocationRequirements:
          json['applicantLocationRequirements'] as List<dynamic>?,
      baseSalary: json['baseSalary'] == null
          ? null
          : BaseSalary.fromJson(json['baseSalary'] as Map<String, dynamic>),
      directApply: json['directApply'] as String?,
      employmentType: json['employmentType'],
      jobLocation: json['jobLocation'] == null
          ? null
          : JobLocation.fromJson(json['jobLocation'] as Map<String, dynamic>),
      jobLocationType: json['jobLocationType'],
      validThrough: json['validThrough'] == null
          ? null
          : DateTime.parse(json['validThrough'] as String),
      status: json['status'] as String?,
      apply: json['apply'] as String?,
      alts: json['alts'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

BaseSalary _$BaseSalaryFromJson(Map<String, dynamic> json) => BaseSalary(
      type: json['@type'] as String?,
      value: json['value'] == null
          ? null
          : Value.fromJson(json['value'] as Map<String, dynamic>),
    );

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      type: json['@type'] as String?,
      value: json['value'] as String?,
    );

HiringOrganization _$HiringOrganizationFromJson(Map<String, dynamic> json) =>
    HiringOrganization(
      type: json['@type'] as String?,
      name: json['name'] as String?,
      sameAs: json['sameAs'] as String?,
      logo: json['logo'],
    );

Identifier _$IdentifierFromJson(Map<String, dynamic> json) => Identifier(
      type: json['@type'] as String?,
      name: json['name'] as String?,
      value: json['value'],
    );

JobLocation _$JobLocationFromJson(Map<String, dynamic> json) => JobLocation(
      type: json['@type'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      type: json['@type'] as String?,
      streetAddress: json['streetAddress'],
      addressLocality: json['addressLocality'],
      addressRegion: json['addressRegion'],
      postalCode: json['postalCode'],
      addressCountry: json['addressCountry'],
    );

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
