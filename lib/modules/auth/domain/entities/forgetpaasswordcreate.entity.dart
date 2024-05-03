import 'package:equatable/equatable.dart';

class CreateForgetNewPasswordEntity extends Equatable {
    const CreateForgetNewPasswordEntity({
        required this.email,
        required this.password,
        required this.passwordConfirmation,
    });

    final String? email;
    final String? password;
    final String? passwordConfirmation;

    CreateForgetNewPasswordEntity copyWith({
        String? email,
        String? password,
        String? passwordConfirmation,
    }) {
        return CreateForgetNewPasswordEntity(
            email: email ?? this.email,
            password: password ?? this.password,
            passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
        );
    }

    factory CreateForgetNewPasswordEntity.fromJson(Map<String, dynamic> json){ 
        return CreateForgetNewPasswordEntity(
            email: json["email"],
            password: json["password"],
            passwordConfirmation: json["password_confirmation"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
    };

    @override
    List<Object?> get props => [
    email, password, passwordConfirmation, ];
}
