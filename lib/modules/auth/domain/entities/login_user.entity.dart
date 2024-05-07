import 'package:equatable/equatable.dart';

class LoginUser extends Equatable {
  LoginUser({
    required this.email,
    required this.password,
  });

  final String? email;
  final String? password;

  factory LoginUser.fromJson(Map<String, dynamic> json){
    return LoginUser(
      email: json["email"],
      password: json["password"],
    );
  }

  @override
  List<Object?> get props => [
    email, password, ];
}
