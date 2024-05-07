// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_password_otp.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPasswordOtpRequestModel _$VerifyPasswordOtpRequestModelFromJson(
        Map<String, dynamic> json) =>
    VerifyPasswordOtpRequestModel(
      otp: json['otp'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$VerifyPasswordOtpRequestModelToJson(
        VerifyPasswordOtpRequestModel instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'email': instance.email,
    };
