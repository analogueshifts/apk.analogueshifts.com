import 'package:equatable/equatable.dart';


class FileUploadDataResponse extends Equatable {
    FileUploadDataResponse({
        required this.baseUrl,
        required this.path,
    });

    final String? baseUrl;
    final String? path;

    FileUploadDataResponse copyWith({
        String? baseUrl,
        String? path,
    }) {
        return FileUploadDataResponse(
            baseUrl: baseUrl ?? this.baseUrl,
            path: path ?? this.path,
        );
    }

    factory FileUploadDataResponse.fromJson(Map<String, dynamic> json){ 
        return FileUploadDataResponse(
            baseUrl: json["base_url"],
            path: json["path"],
        );
    }

    Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "path": path,
    };

    @override
    List<Object?> get props => [
    baseUrl, path, ];
}
