
// import 'package:analogue_shifts_mobile/modules/jobs/data/model/appliedjob.dart';

// // Top-level response model
// class HiresDashboardResponse {
//   final int ?status;
//   final bool? success;
//   final DashboardData? data;

//   HiresDashboardResponse({
//     this.status,
//     this.success,
//     this.data,
//   });

//   factory HiresDashboardResponse.fromJson(Map<String, dynamic> json) {
//     return HiresDashboardResponse(
//       status: json['status'],
//       success: json['success'],
//       data: DashboardData.fromJson(json['data']),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'success': success,
//         'data': data?.toJson(),
//       };
// }

// // The data container holding hires
// class DashboardData {
//   final Hires? hires;

//   DashboardData({this.hires});

//   factory DashboardData.fromJson(Map<String, dynamic> json) {
//     return DashboardData(
//       hires: Hires.fromJson(json['hires']),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'hires': hires?.toJson(),
//       };
// }

// // The Hires model based on the JSON structure
// class Hires {
//   final int currentPage;
//   final List<AppliedJob> ? data; // List of items. Replace 'dynamic' with a specific model if available.
//   final String firstPageUrl;
//   final dynamic from; // Could be int? if known
//   final int lastPage;
//   final String lastPageUrl;
//   final List<Link> links;
//   final dynamic nextPageUrl; // Use String? if appropriate
//   final String path;
//   final int perPage;
//   final dynamic prevPageUrl;
//   final dynamic to;
//   final int total;

//   Hires({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.links,
//     this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     this.prevPageUrl,
//     this.to,
//     required this.total,
//   });

//   factory Hires.fromJson(Map<String, dynamic> json) {
//     var linksList = json['links'] as List;
//     List<Link> links = linksList.map((item) => Link.fromJson(item)).toList();
//     var dataList = json['data']as List;
//     List<AppliedJob> data = dataList.map((item) => AppliedJob.fromJson(item)).toList();

//     return Hires(
//       currentPage: json['current_page'],
//       data: data,
//       firstPageUrl: json['first_page_url'],
//       from: json['from'],
//       lastPage: json['last_page'],
//       lastPageUrl: json['last_page_url'],
//       links: links,
//       nextPageUrl: json['next_page_url'],
//       path: json['path'],
//       perPage: json['per_page'],
//       prevPageUrl: json['prev_page_url'],
//       to: json['to'],
//       total: json['total'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'current_page': currentPage,
//         'data': data,
//         'first_page_url': firstPageUrl,
//         'from': from,
//         'last_page': lastPage,
//         'last_page_url': lastPageUrl,
//         'links': links.map((item) => item.toJson()).toList(),
//         'next_page_url': nextPageUrl,
//         'path': path,
//         'per_page': perPage,
//         'prev_page_url': prevPageUrl,
//         'to': to,
//         'total': total,
//       };
// }

// // Model for pagination links
// class Link {
//   final String? url;
//   final String label;
//   final bool active;

//   Link({
//     this.url,
//     required this.label,
//     required this.active,
//   });

//   factory Link.fromJson(Map<String, dynamic> json) {
//     return Link(
//       url: json['url'],
//       label: json['label'],
//       active: json['active'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'url': url,
//         'label': label,
//         'active': active,
//       };
// }


class HireDashboardResponse {
  final int? status;
  final bool? success;
  final HireData? data;

  HireDashboardResponse({this.status, this.success, this.data});

  factory HireDashboardResponse.fromJson(Map<String, dynamic> json) =>
      HireDashboardResponse(
        status: json['status'],
        success: json['success'],
        data: json['data'] != null ? HireData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'success': success,
        'data': data?.toJson(),
      };
}

class HireData {
  final Hires? hires;

  HireData({this.hires});

  factory HireData.fromJson(Map<String, dynamic> json) => HireData(
        hires:
            json['hires'] != null ? Hires.fromJson(json['hires']) : null,
      );

  Map<String, dynamic> toJson() => {
        'hires': hires?.toJson(),
      };
}

class Hires {
  final int? currentPage;
  final List<JobData>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  Hires({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Hires.fromJson(Map<String, dynamic> json) => Hires(
        currentPage: json['current_page'],
        data: json['data'] != null
            ? List<JobData>.from(
                (json['data'] as List).map((x) => JobData.fromJson(x)))
            : null,
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
        links: json['links'] != null
            ? List<Link>.from(
                (json['links'] as List).map((x) => Link.fromJson(x)))
            : null,
        nextPageUrl: json['next_page_url'],
        path: json['path'],
        perPage: json['per_page'],
        prevPageUrl: json['prev_page_url'],
        to: json['to'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data?.map((x) => x.toJson()).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'last_page': lastPage,
        'last_page_url': lastPageUrl,
        'links': links?.map((x) => x.toJson()).toList(),
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
        'total': total,
      };
}

class JobData {
  final int? id;
  final String? uuid;
  final String? slug;
  final String? userUuid;
  final String? title;
  final String? description;
  final Identifier? identifier;
  final HiringOrganization? hiringOrganization;
  final List<dynamic>? applicantLocationRequirements;
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

  JobData({
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

  factory JobData.fromJson(Map<String, dynamic> json) => JobData(
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
        applicantLocationRequirements:
            json['applicantLocationRequirements'] as List<dynamic>?,
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
        'description': description,
        'identifier': identifier?.toJson(),
        'hiringOrganization': hiringOrganization?.toJson(),
        'applicantLocationRequirements': applicantLocationRequirements,
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

class Identifier {
  final String? type;
  final dynamic name;
  final dynamic value;

  Identifier({this.type, this.name, this.value});

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

class HiringOrganization {
  final String? type;
  final String? name;
  final String? sameAs;
  final String? logo;

  HiringOrganization({this.type, this.name, this.sameAs, this.logo});

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

class BaseSalary {
  final String? type;
  final String? currency;
  final QuantitativeValue? value;

  BaseSalary({this.type, this.currency, this.value});

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

class QuantitativeValue {
  final String? type;
  final String? value;
  final String? unitText;

  QuantitativeValue({this.type, this.value, this.unitText});

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

class JobLocation {
  final String? type;
  final Address? address;

  JobLocation({this.type, this.address});

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

class Address {
  final String? type;
  final String? streetAddress;
  final String? addressLocality;
  final String? addressRegion;
  final dynamic postalCode;
  final String? addressCountry;

  Address(
      {this.type,
      this.streetAddress,
      this.addressLocality,
      this.addressRegion,
      this.postalCode,
      this.addressCountry});

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

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({this.url, this.label, this.active});

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


