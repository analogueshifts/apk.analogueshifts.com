// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadModel _$FileUploadModelFromJson(Map<String, dynamic> json) =>
    FileUploadModel(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FileUploadModelToJson(FileUploadModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      baseUrl: json['base_url'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'base_url': instance.baseUrl,
      'path': instance.path,
    };
