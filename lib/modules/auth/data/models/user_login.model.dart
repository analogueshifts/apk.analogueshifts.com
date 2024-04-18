import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login.model.g.dart';

@JsonSerializable()
class LoginModel extends LoginUser {
  LoginModel({
    required super.email,
    required super.password,
  });


  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

}
