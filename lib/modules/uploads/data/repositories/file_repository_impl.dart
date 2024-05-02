import 'dart:io';

import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/user_login.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/jobsResponseModel.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/repositories/jobs_repository.dart';
import 'package:analogue_shifts_mobile/modules/uploads/data/models/file_upload.model.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/entities/upload_response.dart';
import 'package:analogue_shifts_mobile/modules/uploads/domain/repositories/file_repository.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class UploadRepositoryImpl implements UploadRepository {
  late DioManager dioManager;

  UploadRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, FileUploadDataResponse>> uploadImage(File file) async {
    var dio = Dio();
    try {

      logger.d(file);
       String fileName = file.path.split('/').last;
       var data = FormData.fromMap({
            'upload': 
              await MultipartFile.fromFile(file.path, filename: fileName),
            'type': 'img'
          });
    logger.d(data);
    final _db = getIt<DBService>();
      final response = await dioManager.dio.post(
        'https://api.analogueshifts.com/api/upload',
         data: data,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'multipart/form-data',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer ${_db.getToken()}'
            },
          ),
        );

        dio..interceptors.add(
          AwesomeDioInterceptor(),
        );

        logger.i(response);

      // logger.d(response.data);

      if (response.statusCode == 200) {
        logger.d(response.data);
        final imageModel = FileUploadModel.fromJson(response.data);
        return Right(FileUploadDataResponse(baseUrl: imageModel.data?.baseUrl, path: imageModel.data?.path));
      } else {
        return Left(Exception('Unable to upload image'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as DioException);
    }
  }
}