import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/user_login.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/jobsResponseModel.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/repositories/jobs_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class JobsRepositoryImpl implements JobsRepository {
  late DioManager dioManager;

  JobsRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, JobResponseEntity>> fetchJobs([int? page]) async {
    try {
      final response = await dioManager.dio.get('jobs?page=${page ?? 1}');
      // logger.d(response.data);

      if (response.statusCode == 200) {
        // logger.d(response.data);
        final jobModel = JobResponseEntity.fromJson(response.data);
        return Right(jobModel);
      } else {
        return Left(Exception('Unable to fetch jobs'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, REconmendedJobs>> fetchReconmendedJobs() async {
    try {
      final response = await dioManager.dio.get('jobs/recommend');
      // logger.d(response.data);

      if (response.statusCode == 200) {
        // logger.d(response.data);
        final jobModel = REconmendedJobs.fromJson(response.data);
        return Right(jobModel);
      } else {
        return Left(Exception('Unable to fetch reconmended jobs'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as Exception);
    }
  }
}