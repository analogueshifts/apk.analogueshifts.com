import 'package:analogue_shifts_mobile/modules/auth/data/models/update_user_request.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/forgetpaasswordcreate.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class LoginUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, String>> call(
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

class RegistrationUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, String>> call(RegisterRequest payload) async {
    return await _userRepository.registerUser(payload);
  }
}

class ForgotPasswordUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, dynamic>> call(String email) async {
    return await _userRepository.forgotPassword(email);
  }
}


class VerifyPasswordOtpUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, dynamic>> call(VerifyPasswordEntity payload) async {
    return await _userRepository.verifyPasswordOtp(payload);
  }
}


class InitiateVerificationUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, NoDataResponse>> call() async {
    return await _userRepository.initiateVerificationCode();
  }
}


class UpdateUserUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, UserClass>> call(
      UpdateUserDto payload) async {
    return await _userRepository.updateUser(payload);
  }

}

class FetchUserUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, User>> call() async {
    return await _userRepository.fetchUser();
  }

}

class UpdatePasswordUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, NoDataResponse>> call(CreateForgetNewPasswordEntity payload) async {
    return await _userRepository.createNewPassword(payload);
  }

}

class VerifyEmailUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, User>> call(String otp) async {
    return await _userRepository.verifyEmail(otp);
  }
  

}


class DeleteAccountUseCase {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();

  Future<Either<Exception, bool>> call(bool isDelete, String password, [String? reason]) async {
    return await _userRepository.deleteAccount(isDelete, password, reason);
  }
  
}