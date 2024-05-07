// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobsResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobResponseModel _$JobResponseModelFromJson(Map<String, dynamic> json) =>
    JobResponseModel(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobResponseModelToJson(JobResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      jobs: json['jobs'] == null
          ? null
          : Jobs.fromJson(json['jobs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'jobs': instance.jobs,
    };

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

Map<String, dynamic> _$JobsToJson(Jobs instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

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

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'slug': instance.slug,
      'user_uuid': instance.userUuid,
      'title': instance.title,
      'description': instance.description,
      'identifier': instance.identifier,
      'hiringOrganization': instance.hiringOrganization,
      'applicantLocationRequirements': instance.applicantLocationRequirements,
      'baseSalary': instance.baseSalary,
      'directApply': instance.directApply,
      'employmentType': instance.employmentType,
      'jobLocation': instance.jobLocation,
      'jobLocationType': instance.jobLocationType,
      'validThrough': instance.validThrough?.toIso8601String(),
      'status': instance.status,
      'apply': instance.apply,
      'alts': instance.alts,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

BaseSalary _$BaseSalaryFromJson(Map<String, dynamic> json) => BaseSalary(
      type: json['@type'] as String?,
      value: json['value'] == null
          ? null
          : Value.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseSalaryToJson(BaseSalary instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'value': instance.value,
    };

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      type: json['@type'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      '@type': instance.type,
      'value': instance.value,
    };

HiringOrganization _$HiringOrganizationFromJson(Map<String, dynamic> json) =>
    HiringOrganization(
      type: json['@type'] as String?,
      name: json['name'] as String?,
      sameAs: json['sameAs'] as String?,
      logo: json['logo'],
    );

Map<String, dynamic> _$HiringOrganizationToJson(HiringOrganization instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'name': instance.name,
      'sameAs': instance.sameAs,
      'logo': instance.logo,
    };

Identifier _$IdentifierFromJson(Map<String, dynamic> json) => Identifier(
      type: json['@type'] as String?,
      name: json['name'] as String?,
      value: json['value'],
    );

Map<String, dynamic> _$IdentifierToJson(Identifier instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'name': instance.name,
      'value': instance.value,
    };

JobLocation _$JobLocationFromJson(Map<String, dynamic> json) => JobLocation(
      type: json['@type'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobLocationToJson(JobLocation instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'address': instance.address,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      type: json['@type'] as String?,
      streetAddress: json['streetAddress'],
      addressLocality: json['addressLocality'],
      addressRegion: json['addressRegion'],
      postalCode: json['postalCode'],
      addressCountry: json['addressCountry'],
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      '@type': instance.type,
      'streetAddress': instance.streetAddress,
      'addressLocality': instance.addressLocality,
      'addressRegion': instance.addressRegion,
      'postalCode': instance.postalCode,
      'addressCountry': instance.addressCountry,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
