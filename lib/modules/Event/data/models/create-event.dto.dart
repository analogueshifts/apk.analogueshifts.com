class CreateEventDto {
  CreateEventDto({
    required this.email,
    required this.contact,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.price,
    required this.startsDate,
    required this.endsDate,
    required this.locationType,
    required this.location,
    required this.countriesPrices,
  });

  final String? email;
  final dynamic contact;
  final String? title;
  final String? thumbnail;
  final String? description;
  final double? price;
  final String? startsDate;
  final String? endsDate;
  final String? locationType;
  final String? location;
  final dynamic countriesPrices;

  CreateEventDto copyWith({
    String? email,
    dynamic? contact,
    String? title,
    String? thumbnail,
    String? description,
    double? price,
    String? startsDate,
    String? endsDate,
    String? locationType,
    String? location,
    dynamic? countriesPrices,
  }) {
    return CreateEventDto(
      email: email ?? this.email,
      contact: contact ?? this.contact,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      price: price ?? this.price,
      startsDate: startsDate ?? this.startsDate,
      endsDate: endsDate ?? this.endsDate,
      locationType: locationType ?? this.locationType,
      location: location ?? this.location,
      countriesPrices: countriesPrices ?? this.countriesPrices,
    );
  }

  factory CreateEventDto.fromJson(Map<String, dynamic> json){
    return CreateEventDto(
      email: json["email"],
      contact: json["contact"],
      title: json["title"],
      thumbnail: json["thumbnail"],
      description: json["description"],
      price: json["price"],
      startsDate: json["starts_date"],
      endsDate: json["ends_date"],
      locationType: json["location_type"],
      location: json["location"],
      countriesPrices: json["countriesPrices"],
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "contact": contact,
    "title": title,
    "thumbnail": thumbnail,
    "description": description,
    "price": price,
    "starts_date": startsDate,
    "ends_date": endsDate,
    "location_type": locationType,
    "location": location,
    "countriesPrices": countriesPrices,
  };

}
