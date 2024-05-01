import 'package:analogue_shifts_mobile/modules/auth/data/models/user_login.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/repositories/auth.repository.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/repositories/jobs_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class FetchJobsUseCase {
  final JobsRepository _jobRepository = GetIt.instance<JobsRepository>();


  Future<Either<Exception, JobResponseEntity>> call([int? page]) async {
    return await _jobRepository.fetchJobs();
  }
}