import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
    RegisterRequest({
        required this.name,
        required this.email,
        required this.password,
        required this.passwordConfirmation,
        required this.deviceToken,
        required this.deviceType,
    });

    final String? name;
    final String? email;
    final String? password;
    final String? passwordConfirmation;
    final String? deviceToken;
    final String? deviceType;

    RegisterRequest copyWith({
        String? name,
        String? email,
        String? password,
        String? passwordConfirmation,
        String? deviceToken,
        String? deviceType,
    }) {
        return RegisterRequest(
            name: name ?? this.name,
            email: email ?? this.email,
            password: password ?? this.password,
            passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
            deviceToken: deviceToken ?? this.deviceToken,
            deviceType: deviceType ?? this.deviceType,
        );
    }

    factory RegisterRequest.fromJson(Map<String, dynamic> json){ 
        return RegisterRequest(
            name: json["name"],
            email: json["email"],
            password: json["password"],
            passwordConfirmation: json["password_confirmation"],
            deviceToken: json["device_token"],
            deviceType: json["device_type"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "device_token": deviceToken,
        "device_type": deviceType,
    };

    @override
    List<Object?> get props => [
    name, email, password, passwordConfirmation, deviceToken, deviceType, ];
}
