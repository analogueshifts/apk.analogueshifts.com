import 'dart:convert';
import 'dart:io';

import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/network/network_info.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/nodata_model.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/user_login.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/verify_password_otp.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserRepositoryImpl implements UserRepository {
  late DioManager dioManager;
  final DeviceNetwork _deviceNetwork = GetIt.instance<DeviceNetwork>();


  UserRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, LoginResponse>> loginUser(LoginUser user) async {
    logger.d(user.email);
    try {
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
        logger.d(response.data);
        logger.d(response.data[0]);
        final userModel = LoginResponse.fromJson(response.data);
        return Right(userModel);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, String>> registerUser(RegisterRequest payload) async {
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw Exception("Network Error");
      }
      final response = await dioManager.dio.post(
        'register',
        data: {
          'name': payload.name,
          'email': payload.email,
          'password': payload.password,
          'password_confirmation': payload.passwordConfirmation,
          'device_token': payload.deviceToken,
          'device_type': payload.deviceType
        }
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
        return Left(Exception(response.data));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as Exception);
    }
  }

    @override
  Future<Either<Exception, bool>> forgotPassword(String email) async {
    try {
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
        return Left(Exception(response.data));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, bool>> verifyPasswordOtp(VerifyPasswordEntity payload) async {
    try {
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


  @override
  Future<Either<Exception, NoDataResponse>> initiateVerificationCode() async {
    try {
      final response = await dioManager.dio.post(
          'email/verification-notification');
      logger.d(response.data);

      if (response.statusCode == 200) {
        final data = NoDataResponseModel.fromJson(response.data);
        return Right(NoDataResponse(status: data.status, success: data.success, message: data.message));
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