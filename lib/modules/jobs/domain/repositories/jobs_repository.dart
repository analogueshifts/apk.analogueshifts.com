import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/addCompanyDto.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/company.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart';
import 'package:dartz/dartz.dart';


abstract class JobsRepository {
  Future<Either<Exception, JobResponseEntity>> fetchJobs([int? page]);
  Future<Either<Exception, REconmendedJobs>> fetchReconmendedJobs();
  Future<Either<Exception, NoDataResponse>> addCompany(AddCompanyDto payload);
  Future<Either<Exception, List<Company>>> fetchSavedCompanies([int? page]);
}