class DeleteDto {
    DeleteDto({
        required this.reason,
        required this.password,
    });

    final String? reason;
    final String? password;

    DeleteDto copyWith({
        String? reason,
        String? password,
    }) {
        return DeleteDto(
            reason: reason ?? this.reason,
            password: password ?? this.password,
        );
    }

    factory DeleteDto.fromJson(Map<String, dynamic> json){ 
        return DeleteDto(
            reason: json["reason"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "reason": reason,
        "password": password,
    };

}
