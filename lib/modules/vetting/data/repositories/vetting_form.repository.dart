import 'dart:convert';
import 'dart:io';
import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/uploads/data/models/file_upload.model.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/entities/upload_response.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/repositories/file_repository.dart';
import 'package:analogue_shifts_mobile/modules/vetting/data/models/form.model.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class VettingRepositoryImpl {
  late DioManager dioManager;

  VettingRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, dynamic>> createForm(dynamic payload) async {
    try {
      final response = await dioManager.dio.post(
          'tools/form/create',
          data: payload
      );
      logger.d(response.data);

      if (response.statusCode == 200) {
        final Map<String, dynamic> _results = response.data['data']['form'];
        return Right(_results);
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


  @override
  Future<Either<Exception, List<FormEntity>>> getAllForm() async {
    try {
      final response = await dioManager.dio.get(
          'tools/form'
      );
      logger.d(response.data);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['forms']['data'];
        final List<FormEntity> results = data.map((json) => FormEntity.fromJson(json)).toList();
        // final Map<String, dynamic> _results = response.data['data']['form'];
        return Right(results);
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