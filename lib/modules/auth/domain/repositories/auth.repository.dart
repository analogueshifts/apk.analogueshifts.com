import 'package:analogue_shifts_mobile/modules/auth/domain/entities/forgetpaasswordcreate.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:dartz/dartz.dart';


abstract class UserRepository {
  Future<Either<Exception, LoginResponse>> loginUser(LoginUser user);
  Future<Either<Exception, dynamic>> logoutUser();
   Future<Either<Exception, NoDataResponse>> initiateVerificationCode();
  Future<Either<Exception, String>> registerUser(RegisterRequest payload);
  Future<Either<Exception, bool>> forgotPassword(String email);
  Future<Either<Exception, bool>> verifyPasswordOtp(VerifyPasswordEntity payload);
  Future<Either<Exception, User>> updateUser(User user);
  Future<Either<Exception, User>> fetchUser();
   Future<Either<Exception, NoDataResponse>> createNewPassword(CreateForgetNewPasswordEntity payload);
   Future<Either<Exception, User>> verifyEmail(String otp);
}
