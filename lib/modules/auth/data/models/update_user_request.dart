class UpdateUserDto {
  UpdateUserDto({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.biography,
  });

  final String? username;
  final String? firstName;
  final String? lastName;
  final String? profile;
  final String? biography;

  factory UpdateUserDto.fromJson(Map<String, dynamic> json){
    return UpdateUserDto(
      username: json["username"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      profile: json["profile"],
      biography: json["biography"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "profile": profile,
    "biography": biography,
  };

}
