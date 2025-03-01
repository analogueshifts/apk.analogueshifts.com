

// Your top-level model with a factory constructor:
class JobAppliedResponse {
  int? status;
  bool? success;
  String? message;
  Data? data;

  JobAppliedResponse({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory JobAppliedResponse.fromJson(Map<String, dynamic> json) {
    return JobAppliedResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['status'] = status;
    dataMap['success'] = success;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    return dataMap;
  }
}

class Data {
  String? message;
  Applied? applied;

  Data({this.message, this.applied});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json['message'],
      applied: json['applied'] != null ? Applied.fromJson(json['applied']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['message'] = message;
    if (applied != null) {
      dataMap['applied'] = applied!.toJson();
    }
    return dataMap;
  }
}

class Applied {
  int? currentPage;
  List<AppliedDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Applied({
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

  factory Applied.fromJson(Map<String, dynamic> json) {
    return Applied(
      currentPage: json['current_page'],
      data: json['data'] != null
          ? List<AppliedDatum>.from(json['data'].map((x) => AppliedDatum.fromJson(x)))
          : null,
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: json['links'] != null
          ? List<Link>.from(json['links'].map((x) => Link.fromJson(x)))
          : null,
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['current_page'] = currentPage;
    if (data != null) {
      dataMap['data'] = data!.map((x) => x.toJson()).toList();
    }
    dataMap['first_page_url'] = firstPageUrl;
    dataMap['from'] = from;
    dataMap['last_page'] = lastPage;
    dataMap['last_page_url'] = lastPageUrl;
    if (links != null) {
      dataMap['links'] = links!.map((x) => x.toJson()).toList();
    }
    dataMap['next_page_url'] = nextPageUrl;
    dataMap['path'] = path;
    dataMap['per_page'] = perPage;
    dataMap['prev_page_url'] = prevPageUrl;
    dataMap['to'] = to;
    dataMap['total'] = total;
    return dataMap;
  }
}

class AppliedDatum {
  int? id;
  String? uuid;
  String? userUuid;
  String? jobUuid;
  String? interactionType;
  DateTime? createdAt;
  DateTime? updatedAt;
  AppliedJob? job;

  AppliedDatum({
    this.id,
    this.uuid,
    this.userUuid,
    this.jobUuid,
    this.interactionType,
    this.createdAt,
    this.updatedAt,
    this.job,
  });

  factory AppliedDatum.fromJson(Map<String, dynamic> json) {
    return AppliedDatum(
      id: json['id'],
      uuid: json['uuid'],
      userUuid: json['user_uuid'],
      jobUuid: json['job_uuid'],
      interactionType: json['interaction_type'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      job: json['job'] != null ? AppliedJob.fromJson(json['job']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['uuid'] = uuid;
    dataMap['user_uuid'] = userUuid;
    dataMap['job_uuid'] = jobUuid;
    dataMap['interaction_type'] = interactionType;
    dataMap['created_at'] = createdAt?.toIso8601String();
    dataMap['updated_at'] = updatedAt?.toIso8601String();
    if (job != null) {
      dataMap['job'] = job!.toJson();
    }
    return dataMap;
  }
}

class AppliedJob {
  int? id;
  String? uuid;
  String? slug;
  String? userUuid;
  String? title;
  String? description;
  Identifier? identifier;
  HiringOrganization? hiringOrganization;
  List<dynamic>? applicantLocationRequirements;
  BaseSalary? baseSalary;
  String? directApply;
  String? employmentType;
  JobLocation? jobLocation;
  String? jobLocationType;
  DateTime? validThrough;
  String? status;
  String? apply;
  dynamic alts;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppliedJob({
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

  factory AppliedJob.fromJson(Map<String, dynamic> json) {
    return AppliedJob(
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
      applicantLocationRequirements: json['applicantLocationRequirements'] ?? [],
      baseSalary: json['baseSalary'] != null
          ? BaseSalary.fromJson(json['baseSalary'])
          : null,
      directApply: json['directApply'],
      employmentType: json['employmentType'],
      jobLocation: json['jobLocation'] != null
          ? JobLocation.fromJson(json['jobLocation'])
          : null,
      jobLocationType: json['jobLocationType'],
      validThrough: json['validThrough'] != null
          ? DateTime.parse(json['validThrough'])
          : null,
      status: json['status'],
      apply: json['apply'],
      alts: json['alts'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['uuid'] = uuid;
    dataMap['slug'] = slug;
    dataMap['user_uuid'] = userUuid;
    dataMap['title'] = title;
    dataMap['description'] = description;
    if (identifier != null) {
      dataMap['identifier'] = identifier!.toJson();
    }
    if (hiringOrganization != null) {
      dataMap['hiringOrganization'] = hiringOrganization!.toJson();
    }
    dataMap['applicantLocationRequirements'] = applicantLocationRequirements;
    if (baseSalary != null) {
      dataMap['baseSalary'] = baseSalary!.toJson();
    }
    dataMap['directApply'] = directApply;
    dataMap['employmentType'] = employmentType;
    if (jobLocation != null) {
      dataMap['jobLocation'] = jobLocation!.toJson();
    }
    dataMap['jobLocationType'] = jobLocationType;
    dataMap['validThrough'] =
        validThrough != null ? validThrough!.toIso8601String() : null;
    dataMap['status'] = status;
    dataMap['apply'] = apply;
    dataMap['alts'] = alts;
    dataMap['createdAt'] =
        createdAt != null ? createdAt!.toIso8601String() : null;
    dataMap['updatedAt'] =
        updatedAt != null ? updatedAt!.toIso8601String() : null;
    return dataMap;
  }
}

// You would then implement similar factory constructors and toJson methods
// for the remaining classes: BaseSalary, Value, HiringOrganization,
// Identifier, JobLocation, Address, and Link.

class BaseSalary {
  String? type;
  String? currency;
  Value? value;

  BaseSalary({this.type, this.currency, this.value});

  factory BaseSalary.fromJson(Map<String, dynamic> json) {
    return BaseSalary(
      type: json['type'],
      currency: json['currency'],
      value: json['value'] != null ? Value.fromJson(json['value']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['type'] = type;
    dataMap['currency'] = currency;
    if (value != null) {
      dataMap['value'] = value!.toJson();
    }
    return dataMap;
  }
}

class Value {
  String? type;
  String? value;
  String? unitText;

  Value({this.type, this.value, this.unitText});

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      type: json['type'],
      value: json['value'],
      unitText: json['unitText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
      'unitText': unitText,
    };
  }
}

class HiringOrganization {
  String? type;
  String? name;
  String? sameAs;
  String? logo;

  HiringOrganization({this.type, this.name, this.sameAs, this.logo});

  factory HiringOrganization.fromJson(Map<String, dynamic> json) {
    return HiringOrganization(
      type: json['type'],
      name: json['name'],
      sameAs: json['sameAs'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'sameAs': sameAs,
      'logo': logo,
    };
  }
}

class Identifier {
  String? type;
  dynamic name;
  dynamic value;

  Identifier({this.type, this.name, this.value});

  factory Identifier.fromJson(Map<String, dynamic> json) {
    return Identifier(
      type: json['type'],
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'value': value,
    };
  }
}

class JobLocation {
  String? type;
  Address? address;

  JobLocation({this.type, this.address});

  factory JobLocation.fromJson(Map<String, dynamic> json) {
    return JobLocation(
      type: json['type'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['type'] = type;
    if (address != null) {
      dataMap['address'] = address!.toJson();
    }
    return dataMap;
  }
}

class Address {
  String? type;
  String? streetAddress;
  String? addressLocality;
  String? addressRegion;
  dynamic postalCode;
  String? addressCountry;

  Address({
    this.type,
    this.streetAddress,
    this.addressLocality,
    this.addressRegion,
    this.postalCode,
    this.addressCountry,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      type: json['type'],
      streetAddress: json['streetAddress'],
      addressLocality: json['addressLocality'],
      addressRegion: json['addressRegion'],
      postalCode: json['postalCode'],
      addressCountry: json['addressCountry'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'streetAddress': streetAddress,
      'addressLocality': addressLocality,
      'addressRegion': addressRegion,
      'postalCode': postalCode,
      'addressCountry': addressCountry,
    };
  }
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
