
import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/addCompanyDto.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/company.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/repositories/jobs_repository.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/usecases/fetch_job.usecase.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_state.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/company_saved_success.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JobProvider extends ChangeNotifier {
  final FetchJobsUseCase _fetchJobsUseCase = GetIt.instance<FetchJobsUseCase>();
   final FetchReconmendedJobsUseCase _fetchReconmendedJobsUseCase = GetIt.instance<FetchReconmendedJobsUseCase>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();
  final JobsRepository _jobRepository = GetIt.instance<JobsRepository>();



  final JobState _jobState = JobState();

  JobState get jobhState => _jobState;


  final List<Datum> _jobs = [];
  List<Datum> get job => _jobs;
  int _currentPage = 1;
  int get currentPage => _currentPage;
  int? _lastPage;
  int? get lastPage => _lastPage;
  final List<Company> _companies = [];
  List<Company> get companies => _companies;


  List <Recommendation> _reconmendation = [];
  List <Recommendation>  get reconmendedjobs => _reconmendation;

  void toggleGenerating(bool value) {
    if(jobhState.isGenerating == value)return;
    _jobState.toggleGenerating();
    notifyListeners();
  }

  // Job? get jobs => _jobs;



  Future<void> getJobs(BuildContext context, [int? page]) async {
    logger.d(page);
    toggleGenerating(true);
    notifyListeners();
    final result = await _fetchJobsUseCase.call(page);
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (result) async{
            _lastPage = result.data?.jobs?.lastPage;
            final newJobs = result.data!.jobs!.data!.where((job) => !_jobs.contains(job)).toList();
      _jobs.addAll(newJobs);
      logger.d(_currentPage);
      _currentPage++;
      notifyListeners();

      },
    );
    notifyListeners();
  }


   Future<void> get_reconmended_jobs(BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _fetchReconmendedJobsUseCase.call();
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (result) async{
            if (result.data == null)return;
            _reconmendation = result.data!.recommendation;
      notifyListeners();

      },
    );
    notifyListeners();
  }

  Future<void> registerCompany(AddCompanyDto payload, BuildContext context) async {
    showLoadingDialog(context: context);
    final result = await _jobRepository.addCompany(payload);
    Navigator.pop(context);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (value) async{
        if(context.mounted){
          showDialog(
            barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : const Color(0xff110C00).withOpacity(0.8),
            context: context,
            builder:(context) {
            return CompanySavedSuccess();
          },);

          // AppSnackbar.success(context, message: value.message ?? "Success!");
        }

      },
    );
    notifyListeners();
  }

  Future<void> getSavedCompanies(BuildContext context, [int? page]) async {
    logger.d(page);

    toggleGenerating(true);
    notifyListeners();
    final result = await _jobRepository.fetchSavedCompanies(page);
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (result) async{
              companies.clear();
                companies.addAll(result);
        notifyListeners();

      },
    );
    notifyListeners();
  }
}