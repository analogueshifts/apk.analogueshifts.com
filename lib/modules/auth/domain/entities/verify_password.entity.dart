import 'package:equatable/equatable.dart';

class VerifyPasswordEntity extends Equatable {
    const VerifyPasswordEntity({
        required this.otp,
        required this.email,
    });

    final String? otp;
    final String? email;

    factory VerifyPasswordEntity.fromJson(Map<String, dynamic> json){ 
        return VerifyPasswordEntity(
            otp: json["otp"],
            email: json["email"],
        );
    }

    @override
    List<Object?> get props => [
    otp, email, ];
}
