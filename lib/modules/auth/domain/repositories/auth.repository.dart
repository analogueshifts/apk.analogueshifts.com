import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:dartz/dartz.dart';


abstract class UserRepository {
  Future<Either<Exception, LoginResponse>> loginUser(LoginUser user);
  Future<Either<Exception, dynamic>> logoutUser();
}