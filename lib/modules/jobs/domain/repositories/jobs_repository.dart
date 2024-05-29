
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart';
import 'package:dartz/dartz.dart';


abstract class JobsRepository {
  Future<Either<Exception, JobResponseEntity>> fetchJobs([int? page]);
  Future<Either<Exception, REconmendedJobs>> fetchReconmendedJobs();
}