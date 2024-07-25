class AddCompanyDto {
  AddCompanyDto({
    required this.name,
    required this.industry,
    required this.location,
    required this.email,
    required this.contact,
    required this.website,
    required this.logo,
    required this.description,
    required this.metadata,
  });

  final String? name;
  final String? industry;
  final String? location;
  final String? email;
  final String? contact;
  final String? website;
  final String? logo;
  final String? description;
  final dynamic metadata;

  factory AddCompanyDto.fromJson(Map<String, dynamic> json){
    return AddCompanyDto(
      name: json["name"],
      industry: json["industry"],
      location: json["location"],
      email: json["email"],
      contact: json["contact"],
      website: json["website"],
      logo: json["logo"],
      description: json["description"],
      metadata: json["metadata"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "industry": industry,
    "location": location,
    "email": email,
    "contact": contact,
    "website": website,
    "logo": logo,
    "description": description,
    "metadata": metadata,
  };

}
