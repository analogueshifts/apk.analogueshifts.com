import 'package:json_annotation/json_annotation.dart';

part 'registration_request.model.g.dart';

@JsonSerializable()
class RegisterRequest {
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

    @JsonKey(name: 'password_confirmation') 
    final String? passwordConfirmation;

    @JsonKey(name: 'device_token') 
    final String? deviceToken;

    @JsonKey(name: 'device_type') 
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

    factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

}
