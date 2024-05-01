import 'package:equatable/equatable.dart';

class NoDataResponse extends Equatable {
    NoDataResponse({
        required this.status,
        required this.success,
        required this.message,
    });

    final int? status;
    final bool? success;
    final String? message;

    factory NoDataResponse.fromJson(Map<String, dynamic> json){ 
        return NoDataResponse(
            status: json["status"],
            success: json["success"],
            message: json["message"],
        );
    }

    @override
    List<Object?> get props => [
    status, success, message, ];
}
