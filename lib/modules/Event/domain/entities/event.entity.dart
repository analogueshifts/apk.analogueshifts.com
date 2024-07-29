import 'package:equatable/equatable.dart';

class Event extends Equatable {
  Event({
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
  final String? price;
  final DateTime? startsDate;
  final DateTime? endsDate;
  final String? locationType;
  final String? location;
  final dynamic countriesPrices;

  Event copyWith({
    String? email,
    dynamic? contact,
    String? title,
    String? thumbnail,
    String? description,
    String? price,
    DateTime? startsDate,
    DateTime? endsDate,
    String? locationType,
    String? location,
    dynamic? countriesPrices,
  }) {
    return Event(
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

  factory Event.fromJson(Map<String, dynamic> json){
    return Event(
      email: json["email"],
      contact: json["contact"],
      title: json["title"],
      thumbnail: json["thumbnail"],
      description: json["description"],
      price: json["price"],
      startsDate: DateTime.tryParse(json["starts_date"] ?? ""),
      endsDate: DateTime.tryParse(json["ends_date"] ?? ""),
      locationType: json["location_type"],
      location: json["location"],
      countriesPrices: json["countriesPrices"],
    );
  }

  @override
  List<Object?> get props => [
    email, contact, title, thumbnail, description, price, startsDate, endsDate, locationType, location, countriesPrices, ];
}
