class AddJobDto {
    AddJobDto({
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
    });

    final String title;
    final String description;
    final dynamic identifier;
    final dynamic hiringOrganization;
    final dynamic applicantLocationRequirements;
    final dynamic baseSalary;
    final String directApply;
    final dynamic employmentType;
    final dynamic jobLocation;
    final dynamic jobLocationType;
    final dynamic validThrough;
    final String status;
    final String apply;

    factory AddJobDto.fromJson(Map<String, dynamic> json){ 
        return AddJobDto(
            title: json["title"] ?? "",
            description: json["description"] ?? "",
            identifier: json["identifier"],
            hiringOrganization: json["hiringOrganization"],
            applicantLocationRequirements: json["applicantLocationRequirements"],
            baseSalary: json["baseSalary"],
            directApply: json["directApply"] ?? "",
            employmentType: json["employmentType"],
            jobLocation: json["jobLocation"],
            jobLocationType: json["jobLocationType"],
            validThrough: json["validThrough"],
            status: json["status"] ?? "",
            apply: json["apply"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "identifier": identifier,
        "hiringOrganization": hiringOrganization,
        "applicantLocationRequirements": applicantLocationRequirements,
        "baseSalary": baseSalary,
        "directApply": directApply,
        "employmentType": employmentType,
        "jobLocation": jobLocation,
        "jobLocationType": jobLocationType,
        "validThrough": validThrough,
        "status": status,
        "apply": apply,
    };

}
