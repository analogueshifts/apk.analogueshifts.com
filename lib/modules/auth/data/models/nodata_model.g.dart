// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nodata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoDataResponseModel _$NoDataResponseModelFromJson(Map<String, dynamic> json) =>
    NoDataResponseModel(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NoDataResponseModelToJson(
        NoDataResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
    };
