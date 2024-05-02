import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.model.g.dart';

@JsonSerializable()
class UpdateUser {
    UpdateUser({
        required this.name,
        required this.username,
        required this.tel,
        required this.profile,
    });

    final String? name;
    final String? username;
    final String? tel;
    final String? profile;

    UpdateUser copyWith({
        String? name,
        String? username,
        String? tel,
        String? profile,
    }) {
        return UpdateUser(
            name: name ?? this.name,
            username: username ?? this.username,
            tel: tel ?? this.tel,
            profile: profile ?? this.profile,
        );
    }

    factory UpdateUser.fromJson(Map<String, dynamic> json) => _$UpdateUserFromJson(json);

    Map<String, dynamic> toJson() => _$UpdateUserToJson(this);

}
