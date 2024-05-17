import 'package:equatable/equatable.dart';

class REconmendedJobs extends Equatable {
    REconmendedJobs({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final Data? data;

    REconmendedJobs copyWith({
        int? status,
        bool? success,
        Data? data,
    }) {
        return REconmendedJobs(
            status: status ?? this.status,
            success: success ?? this.success,
            data: data ?? this.data,
        );
    }

    factory REconmendedJobs.fromJson(Map<String, dynamic> json){ 
        return REconmendedJobs(
            status: json["status"],
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
    };

    @override
    List<Object?> get props => [
    status, success, data, ];
}

class Data extends Equatable {
    Data({
        required this.recommendation,
    });

    final List<Recommendation> recommendation;

    Data copyWith({
        List<Recommendation>? recommendation,
    }) {
        return Data(
            recommendation: recommendation ?? this.recommendation,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            recommendation: json["recommendation"] == null ? [] : List<Recommendation>.from(json["recommendation"]!.map((x) => Recommendation.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "recommendation": recommendation.map((x) => x?.toJson()).toList(),
    };

    @override
    List<Object?> get props => [
    recommendation, ];
}

class Recommendation extends Equatable {
    Recommendation({
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
    final String? userUuid;
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

    Recommendation copyWith({
        int? id,
        String? uuid,
        String? slug,
        String? userUuid,
        String? title,
        String? description,
        Identifier? identifier,
        HiringOrganization? hiringOrganization,
        List<ApplicantLocationRequirement>? applicantLocationRequirements,
        BaseSalary? baseSalary,
        String? directApply,
        String? employmentType,
        JobLocation? jobLocation,
        String? jobLocationType,
        DateTime? validThrough,
        String? status,
        String? apply,
        dynamic? alts,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return Recommendation(
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

    factory Recommendation.fromJson(Map<String, dynamic> json){ 
        return Recommendation(
            id: json["id"],
            uuid: json["uuid"],
            slug: json["slug"],
            userUuid: json["user_uuid"],
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
        "uuid": uuid,
        "slug": slug,
        "user_uuid": userUuid,
        "title": title,
        "description": description,
        "identifier": identifier?.toJson(),
        "hiringOrganization": hiringOrganization?.toJson(),
        "applicantLocationRequirements": applicantLocationRequirements.map((x) => x?.toJson()).toList(),
        "baseSalary": baseSalary?.toJson(),
        "directApply": directApply,
        "employmentType": employmentType,
        "jobLocation": jobLocation?.toJson(),
        "jobLocationType": jobLocationType,
        "validThrough": "${validThrough?.year.toString().padLeft(4)}-${validThrough?.month.toString().padLeft(2)}-${validThrough!.day.toString().padLeft(2)}",
        "status": status,
        "apply": apply,
        "alts": alts,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
    id, uuid, slug, userUuid, title, description, identifier, hiringOrganization, applicantLocationRequirements, baseSalary, directApply, employmentType, jobLocation, jobLocationType, validThrough, status, apply, alts, createdAt, updatedAt, ];
}

class ApplicantLocationRequirement extends Equatable {
    ApplicantLocationRequirement({
        required this.type,
        required this.name,
    });

    final String? type;
    final String? name;

    ApplicantLocationRequirement copyWith({
        String? type,
        String? name,
    }) {
        return ApplicantLocationRequirement(
            type: type ?? this.type,
            name: name ?? this.name,
        );
    }

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
        required this.currency,
        required this.value,
    });

    final String? type;
    final String? currency;
    final Value? value;

    BaseSalary copyWith({
        String? type,
        String? currency,
        Value? value,
    }) {
        return BaseSalary(
            type: type ?? this.type,
            currency: currency ?? this.currency,
            value: value ?? this.value,
        );
    }

    factory BaseSalary.fromJson(Map<String, dynamic> json){ 
        return BaseSalary(
            type: json["@type"],
            currency: json["currency"],
            value: json["value"] == null ? null : Value.fromJson(json["value"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "@type": type,
        "currency": currency,
        "value": value?.toJson(),
    };

    @override
    List<Object?> get props => [
    type, currency, value, ];
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

    Value copyWith({
        String? type,
        String? value,
        String? unitText,
    }) {
        return Value(
            type: type ?? this.type,
            value: value ?? this.value,
            unitText: unitText ?? this.unitText,
        );
    }

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

    JobLocation copyWith({
        String? type,
        Address? address,
    }) {
        return JobLocation(
            type: type ?? this.type,
            address: address ?? this.address,
        );
    }

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
