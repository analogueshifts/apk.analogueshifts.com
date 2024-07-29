import 'package:equatable/equatable.dart';

class JobRole extends Equatable {
  JobRole({
    required this.name,
  });

  final String? name;

  JobRole copyWith({
    String? name,
  }) {
    return JobRole(
      name: name ?? this.name,
    );
  }

  factory JobRole.fromJson(Map<String, dynamic> json){
    return JobRole(
      name: json["name"],
    );
  }

  @override
  List<Object?> get props => [
    name, ];
}
