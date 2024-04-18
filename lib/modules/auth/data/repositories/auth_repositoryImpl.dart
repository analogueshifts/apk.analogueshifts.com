import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/user_login.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class UserRepositoryImpl implements UserRepository {
  late DioManager dioManager;


  UserRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, LoginResponse>> loginUser(LoginUser user) async {
    logger.d(user.email);
    try {
      final response = await dioManager.dio.post(
        'login',
        data: {
          'email': user.email,
          'password': user.password
        }
      );
      logger.d(response.data);

      if (response.statusCode == 200) {
        logger.d(response.data);
        final userModel = LoginResponse.fromJson(response.data);
        return Right(userModel);
      } else {
        return Left(Exception('Registration failed'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, dynamic>> logoutUser() async {
    try {
      final response = await dioManager.dio.post(
          'logout');
      logger.d(response.data);

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(Exception(response.data));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as Exception);
    }
  }
}