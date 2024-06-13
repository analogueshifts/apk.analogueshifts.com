import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
    RegisterRequest({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.passwordConfirmation,
        required this.deviceToken,
    });

    final String? firstName;
    final String? lastName;
    final String? email;
    final String? password;
    final String? passwordConfirmation;
    final String? deviceToken;

    RegisterRequest copyWith({
        String? firstName,
        String? lastName,
        String? email,
        String? password,
        String? passwordConfirmation,
        String? deviceToken,
    }) {
        return RegisterRequest(
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            password: password ?? this.password,
            passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
            deviceToken: deviceToken ?? this.deviceToken,
        );
    }

    factory RegisterRequest.fromJson(Map<String, dynamic> json){
        return RegisterRequest(
            firstName: json["first_name"],
            lastName: json["last_name"],
            email: json["email"],
            password: json["password"],
            passwordConfirmation: json["password_confirmation"],
            deviceToken: json["device_token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "device_token": deviceToken,
    };

    @override
    List<Object?> get props => [
        firstName, lastName, email, password, passwordConfirmation, deviceToken, ];
}

