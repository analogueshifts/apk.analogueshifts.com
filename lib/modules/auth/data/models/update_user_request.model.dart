class UpdateUser {
    UpdateUser({
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.profile,
    });

    final String? firstName;
    final String? lastName;
    final String? username;
    final String? profile;

    factory UpdateUser.fromJson(Map<String, dynamic> json){
        return UpdateUser(
            firstName: json["first_name"],
            lastName: json["last_name"],
            username: json["username"],
            profile: json["profile"],
        );
    }

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "profile": profile,
    };

}

