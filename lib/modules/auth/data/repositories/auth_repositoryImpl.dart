import 'dart:convert';
import 'dart:io';
import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/network_info.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/nodata_model.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/update_user_request.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/update_user_request.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/verify_password_otp.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/forgetpaasswordcreate.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRepositoryImpl implements UserRepository {
  late DioManager dioManager;
  final DeviceNetwork _deviceNetwork = GetIt.instance<DeviceNetwork>();

final _db = getIt<DBService>();
  UserRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, String>> loginUser(LoginUser user) async {
    logger.d(user.email);
    logger.d(dotenv.env['ENV']);
  logger.d(dotenv.env['BASE_URL']);
  logger.d(dotenv.env['SECRET_KEY']);
    try {
      await _db.removeAuthToken();
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }
      
      final response = await dioManager.dio.post(
        'login',
        data: {
          'email': user.email,
          'password': user.password
        }
      );
      logger.d(response.data);
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        final userModel = response.data;
        logger.d(userModel['data']['token']);
        return Right(userModel['data']['token']);
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, String>> registerUser(RegisterRequest payload) async {
    try {
      await _db.removeAuthToken();
      if (await _deviceNetwork.isConnected() == false) {
        throw Exception("Network Error");
      }
      
      final response = await dioManager.dio.post(
        'register',
        data:payload.toJson(),
         options: Options(
            headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: HttpHeaders.authorizationHeader
            },
          ),
      );
      logger.d(response.data);
      logger.i(' from repo class:${response.data[0]['data']['token']}');
      if (response.statusCode == 200) {
        final userModel = response.data[0]['data']['token'];
        logger.e(userModel);
        if (userModel == null) {
          throw Exception('Registration error');
        }
        logger.d("runnunfb_____>>>>>____");
        return Right(userModel.toString());
      } else {
        throw Exception(response.data);
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }

    @override
  Future<Either<Exception, bool>> forgotPassword(String email) async {
    try {
      logger.w("RUnning forget oassword");
      await _db.removeAuthToken();
      final response = await dioManager.dio.post(
        'forgot-password',
        data: {
          'email': email.trim(),
        }
      );
      logger.d(response.data);

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        logger.w(response.data);
        return Left(Exception(response.data));
      }
    } on DioException catch (e) {
       logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, bool>> verifyPasswordOtp(VerifyPasswordEntity payload) async {
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }

      final response = await dioManager.dio.post(
        'check-otp',
        data: json.encode(VerifyPasswordOtpRequestModel(otp: payload.otp, email: payload.email)),
      );
      logger.d(response.data);

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Exception(response.data));
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
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
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }


  @override
  Future<Either<Exception, NoDataResponse>> initiateVerificationCode() async {
    try { if (await _deviceNetwork.isConnected() == false) {
      throw const SocketException('Network Error');
    }
    final response = await dioManager.dio.post(
          'email/verification-notification');
      logger.d(response.data);

      if (response.statusCode == 200) {
        final data = NoDataResponseModel.fromJson(response.data);
        return Right(NoDataResponse(status: data.status, success: data.success, message: data.message));
      } else {
        return Left(Exception(response.data));
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }

   @override
  Future<Either<Exception, UserClass>> updateUser(UpdateUserDto user) async {
    // logger.d(user.email);
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }
      
      final response = await dioManager.dio.post(
        'update/profile',
         data: user.toJson()
      );
      logger.d(response.data);
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        logger.d(response.data);
        logger.d(response.data[0]);
        final userModel = UserClass.fromJson(response.data['data']['user']);
        logger.wtf(userModel);
        return Right(userModel);
      } else {
        throw Exception('User update failed');
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }
  

   @override
  Future<Either<Exception, User>> fetchUser() async {
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }

      final response = await dioManager.dio.get('user');
      logger.wtf(response);

      if (response.statusCode == 200) {
        logger.i(response.data);
        // logger.d(response.data);
        final userModel = User.fromJson(response.data);
        logger.d('fetching user $userModel');
        return Right(userModel);
      }
       else {
        throw Exception('Failed to fetch user.');
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, NoDataResponse>> createNewPassword(CreateForgetNewPasswordEntity payload) async {
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }

      final response = await dioManager.dio.post(
        'reset-password',
         data: {
          "email": payload.email,
          "password": payload.password,
          "password_confirmation": payload.passwordConfirmation
         }
      );
      logger.d(response.data);
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        logger.d(response.data);
        logger.d(response.data[0]);
        final results = NoDataResponse.fromJson(response.data);
        return Right(results);
      } else {
        throw Exception('User update failed');
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }

   @override
  Future<Either<Exception, User>> verifyEmail(String otp) async {
    logger.d('otp---<< $otp');
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }
      
      final response = await dioManager.dio.post(
        'email/verification-otp',
         data: {
          "OTP": otp
         }
      );
      logger.d(response.data);
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        logger.d(response.data);
        logger.d(response.data[0]);
        final userModel = User.fromJson(response.data['data']['user']);
        return Right(userModel);
      } else {
        throw Exception('Verification failed');
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }


   @override
  Future<Either<Exception, bool>> deleteAccount(bool isDelete, String password, [String? reason]) async {
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }

      final response = await dioManager.dio.post(
       isDelete ?  'user/account/delete' : 'user/account/disable',
        data: {
          'password': password.trim(),
          reason == null ? null : 'reason': reason
        }
      );
      logger.d(response.data);

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Exception(response.data));
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }
}