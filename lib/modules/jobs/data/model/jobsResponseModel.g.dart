// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobsResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobResponseModel _$JobResponseModelFromJson(Map<String, dynamic> json) =>
    JobResponseModel(
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobResponseModelToJson(JobResponseModel instance) =>
    <String, dynamic>{
      'jobs': instance.jobs,
    };

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      id: json['id'] as int?,
      slug: json['slug'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      identifier: json['identifier'] == null
          ? null
          : Identifier.fromJson(json['identifier'] as Map<String, dynamic>),
      hiringOrganization: json['hiringOrganization'] == null
          ? null
          : HiringOrganization.fromJson(
              json['hiringOrganization'] as Map<String, dynamic>),
      applicantLocationRequirements: (json['applicantLocationRequirements']
              as List<dynamic>?)
          ?.map((e) =>
              ApplicantLocationRequirement.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseSalary: json['baseSalary'] == null
          ? null
          : BaseSalary.fromJson(json['baseSalary'] as Map<String, dynamic>),
      directApply: json['directApply'] as String?,
      employmentType: json['employmentType'] as String?,
      jobLocation: json['jobLocation'] == null
          ? null
          : JobLocation.fromJson(json['jobLocation'] as Map<String, dynamic>),
      jobLocationType: json['jobLocationType'] as String?,
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

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'user_id': instance.userId,
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

ApplicantLocationRequirement _$ApplicantLocationRequirementFromJson(
        Map<String, dynamic> json) =>
    ApplicantLocationRequirement(
      type: json['@type'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ApplicantLocationRequirementToJson(
        ApplicantLocationRequirement instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'name': instance.name,
    };

BaseSalary _$BaseSalaryFromJson(Map<String, dynamic> json) => BaseSalary(
      type: json['@type'] as String?,
      value: json['value'] == null
          ? null
          : Value.fromJson(json['value'] as Map<String, dynamic>),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$BaseSalaryToJson(BaseSalary instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'value': instance.value,
      'currency': instance.currency,
    };

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      type: json['@type'] as String?,
      value: json['value'] as String?,
      unitText: json['unitText'] as String?,
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      '@type': instance.type,
      'value': instance.value,
      'unitText': instance.unitText,
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
      addressLocality: json['addressLocality'] as String?,
      addressRegion: json['addressRegion'],
      postalCode: json['postalCode'],
      addressCountry: json['addressCountry'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      '@type': instance.type,
      'streetAddress': instance.streetAddress,
      'addressLocality': instance.addressLocality,
      'addressRegion': instance.addressRegion,
      'postalCode': instance.postalCode,
      'addressCountry': instance.addressCountry,
    };
