// Model for each Job posting
class AddJobDto {
  final int? id;
  final String? uuid;
  final String? slug;
  final String? userUuid;
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
  final String? validThrough;
  final String? status;
  final String? apply;
  final dynamic alts;
  final String? createdAt;
  final String? updatedAt;

  AddJobDto({
    this.id,
    this.uuid,
    this.slug,
    this.userUuid,
    this.title,
    this.description,
    this.identifier,
    this.hiringOrganization,
    this.applicantLocationRequirements,
    this.baseSalary,
    this.directApply,
    this.employmentType,
    this.jobLocation,
    this.jobLocationType,
    this.validThrough,
    this.status,
    this.apply,
    this.alts,
    this.createdAt,
    this.updatedAt,
  });

  factory AddJobDto.fromJson(Map<String, dynamic> json) => AddJobDto(
        id: json['id'],
        uuid: json['uuid'],
        slug: json['slug'],
        userUuid: json['user_uuid'],
        title: json['title'],
        description: json['description'],
        identifier: json['identifier'] != null
            ? Identifier.fromJson(json['identifier'])
            : null,
        hiringOrganization: json['hiringOrganization'] != null
            ? HiringOrganization.fromJson(json['hiringOrganization'])
            : null,
        applicantLocationRequirements:json['applicantLocationRequirements'] != null
            ? List<ApplicantLocationRequirement>.from(
                (json['applicantLocationRequirements'] as List)
                    .map((x) => ApplicantLocationRequirement.fromJson(x)))
            : null,
        baseSalary: json['baseSalary'] != null
            ? BaseSalary.fromJson(json['baseSalary'])
            : null,
        directApply: json['directApply'],
        employmentType: json['employmentType'],
        jobLocation: json['jobLocation'] != null
            ? JobLocation.fromJson(json['jobLocation'])
            : null,
        jobLocationType: json['jobLocationType'],
        validThrough: json['validThrough'],
        status: json['status']?.toString(),
        apply: json['apply'],
        alts: json['alts'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uuid': uuid,
        'slug': slug,
        'user_uuid': userUuid,
        'title': title,
        'description': description??'',
        'identifier': identifier?.toJson(),
        'hiringOrganization': hiringOrganization?.toJson(),
        'applicantLocationRequirements': applicantLocationRequirements
            ?.map((x) => x.toJson())
            .toList(),
        'baseSalary': baseSalary?.toJson(),
        'directApply': directApply,
        'employmentType': employmentType,
        'jobLocation': jobLocation?.toJson(),
        'jobLocationType': jobLocationType,
        'validThrough': validThrough,
        'status': status,
        'apply': apply,
        'alts': alts,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}



class ApplicantLocationRequirement {
  final String? type;
  final String? name;

  ApplicantLocationRequirement({this.type, this.name});

  factory ApplicantLocationRequirement.fromJson(Map<String, dynamic> json) =>
      ApplicantLocationRequirement(
        type: json['@type'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        '@type': type,
        'name': name,
      };
}

// Model for the Identifier object
class Identifier {
  final String? type;
  final dynamic name;
  final dynamic value;

  Identifier({
    this.type,
    this.name,
    this.value,
  });

  factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        type: json['@type'],
        name: json['name'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        '@type': type,
        'name': name,
        'value': value,
      };
}

// Model for the HiringOrganization object
class HiringOrganization {
  final String? type;
  final String? name;
  final String? sameAs;
  final String? logo;

  HiringOrganization({
    this.type,
    this.name,
    this.sameAs,
    this.logo,
  });

  factory HiringOrganization.fromJson(Map<String, dynamic> json) =>
      HiringOrganization(
        type: json['@type'],
        name: json['name'],
        sameAs: json['sameAs'],
        logo: json['logo'],
      );

  Map<String, dynamic> toJson() => {
        '@type': type,
        'name': name,
        'sameAs': sameAs,
        'logo': logo,
      };
}

// Model for the BaseSalary object
class BaseSalary {
  final String? type;
  final String? currency;
  final QuantitativeValue? value;

  BaseSalary({
    this.type,
    this.currency,
    this.value,
  });

  factory BaseSalary.fromJson(Map<String, dynamic> json) => BaseSalary(
        type: json['@type'],
        currency: json['currency'],
        value: json['value'] != null
            ? QuantitativeValue.fromJson(json['value'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        '@type': type,
        'currency': currency,
        'value': value?.toJson(),
      };
}

// Model for the QuantitativeValue object
class QuantitativeValue {
  final String? type;
  final String? value;
  final String? unitText;

  QuantitativeValue({
    this.type,
    this.value,
    this.unitText,
  });

  factory QuantitativeValue.fromJson(Map<String, dynamic> json) =>
      QuantitativeValue(
        type: json['@type'],
        value: json['value'],
        unitText: json['unitText'],
      );

  Map<String, dynamic> toJson() => {
        '@type': type,
        'value': value,
        'unitText': unitText,
      };
}

// Model for the JobLocation object
class JobLocation {
  final String? type;
  final Address? address;

  JobLocation({
    this.type,
    this.address,
  });

  factory JobLocation.fromJson(Map<String, dynamic> json) => JobLocation(
        type: json['@type'],
        address:
            json['address'] != null ? Address.fromJson(json['address']) : null,
      );

  Map<String, dynamic> toJson() => {
        '@type': type,
        'address': address?.toJson(),
      };
}

// Model for the Address object
class Address {
  final String? type;
  final String? streetAddress;
  final String? addressLocality;
  final String? addressRegion;
  final dynamic postalCode;
  final String? addressCountry;

  Address({
    this.type,
    this.streetAddress,
    this.addressLocality,
    this.addressRegion,
    this.postalCode,
    this.addressCountry,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        type: json['@type'],
        streetAddress: json['streetAddress'],
        addressLocality: json['addressLocality'],
        addressRegion: json['addressRegion'],
        postalCode: json['postalCode'],
        addressCountry: json['addressCountry'],
      );

  Map<String, dynamic> toJson() => {
        '@type': type,
        'streetAddress': streetAddress,
        'addressLocality': addressLocality,
        'addressRegion': addressRegion,
        'postalCode': postalCode,
        'addressCountry': addressCountry,
      };
}

// Model for pagination links
class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json['url'],
        label: json['label'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'label': label,
        'active': active,
      };
}
