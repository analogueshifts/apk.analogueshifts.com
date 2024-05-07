import 'package:json_annotation/json_annotation.dart';

part 'nodata_model.g.dart';

@JsonSerializable()
class NoDataResponseModel {
    NoDataResponseModel({
        required this.status,
        required this.success,
        required this.message,
    });

    final int? status;
    final bool? success;
    final String? message;

    NoDataResponseModel copyWith({
        int? status,
        bool? success,
        String? message,
    }) {
        return NoDataResponseModel(
            status: status ?? this.status,
            success: success ?? this.success,
            message: message ?? this.message,
        );
    }

    factory NoDataResponseModel.fromJson(Map<String, dynamic> json) => _$NoDataResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$NoDataResponseModelToJson(this);

}
