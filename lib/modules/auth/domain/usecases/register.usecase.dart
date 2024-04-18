import 'package:analogue_shifts_mobile/modules/auth/data/models/user_login.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class LoginUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, LoginResponse>> call(
      LoginUser loginRequest) async {
    return await _userRepository.loginUser(loginRequest);
  }

}

class LogoutUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, dynamic>> call() async {
    return await _userRepository.logoutUser();
  }

}