import 'package:json_annotation/json_annotation.dart';

part 'file_upload.model.g.dart';

@JsonSerializable()
class FileUploadModel {
    FileUploadModel({
        required this.status,
        required this.success,
        required this.message,
        required this.data,
    });

    final int? status;
    final bool? success;
    final String? message;
    final Data? data;

    FileUploadModel copyWith({
        int? status,
        bool? success,
        String? message,
        Data? data,
    }) {
        return FileUploadModel(
            status: status ?? this.status,
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );
    }

    factory FileUploadModel.fromJson(Map<String, dynamic> json) => _$FileUploadModelFromJson(json);

    Map<String, dynamic> toJson() => _$FileUploadModelToJson(this);

}

@JsonSerializable()
class Data {
    Data({
        required this.baseUrl,
        required this.path,
    });

    @JsonKey(name: 'base_url') 
    final String? baseUrl;
    final String? path;

    Data copyWith({
        String? baseUrl,
        String? path,
    }) {
        return Data(
            baseUrl: baseUrl ?? this.baseUrl,
            path: path ?? this.path,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);

}
