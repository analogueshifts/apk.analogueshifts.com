import 'package:json_annotation/json_annotation.dart';

part 'verify_password_otp.model.g.dart';

@JsonSerializable()
class VerifyPasswordOtpRequestModel {
    VerifyPasswordOtpRequestModel({
        required this.otp,
        required this.email,
    });

    final String? otp;
    final String? email;

    VerifyPasswordOtpRequestModel copyWith({
        String? otp,
        String? email,
    }) {
        return VerifyPasswordOtpRequestModel(
            otp: otp ?? this.otp,
            email: email ?? this.email,
        );
    }

    factory VerifyPasswordOtpRequestModel.fromJson(Map<String, dynamic> json) => _$VerifyPasswordOtpRequestModelFromJson(json);

    Map<String, dynamic> toJson() => _$VerifyPasswordOtpRequestModelToJson(this);

}
