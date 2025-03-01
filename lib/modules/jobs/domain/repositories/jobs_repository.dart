import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/addCompanyDto.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/addJobDto.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/appliedjob.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/postjobresponse.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/company.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart';
import 'package:dartz/dartz.dart';


abstract class JobsRepository {
  Future<Either<Exception, JobResponseEntity>> fetchJobs([int? page]);
  Future<Either<Exception, JobResponseEntity>> fetchSearchJobs(String search, [int? page]);
  Future<Either<Exception, REconmendedJobs>> fetchReconmendedJobs([int? page]);
  Future<Either<Exception, NoDataResponse>> addCompany(AddCompanyDto payload);
  Future<Either<Exception, NoDataResponse>> addJob(AddJobDto payload);
  Future<Either<Exception, NoDataResponse>> saveJob(String slug);
  Future<Either<Exception, HireDashboardResponse>> fetchCreatedJobs([int? page]);
  Future<Either<Exception, JobAppliedResponse>> fetchAppliedJob([int? page]);
  Future<Either<Exception, JobResponseEntity>> fetchBookmarksJob([int? page]);
  Future<Either<Exception, List<Company>>> fetchSavedCompanies([int? page]);
}