// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUser _$UpdateUserFromJson(Map<String, dynamic> json) => UpdateUser(
      name: json['name'] as String?,
      username: json['username'] as String?,
      tel: json['tel'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$UpdateUserToJson(UpdateUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'tel': instance.tel,
      'profile': instance.profile,
    };
