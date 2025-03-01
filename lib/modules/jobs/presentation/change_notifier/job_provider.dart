// ignore_for_file: use_build_context_synchronously

import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/addCompanyDto.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/addJobDto.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/appliedjob.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/model/postjobresponse.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/company.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/repositories/jobs_repository.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/usecases/fetch_job.usecase.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_state.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/company_saved_success.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JobProvider extends ChangeNotifier {
  final FetchJobsUseCase _fetchJobsUseCase = GetIt.instance<FetchJobsUseCase>();
  final FetchSearchJobsUseCase _fetchSearchJobsUseCase =
      GetIt.instance<FetchSearchJobsUseCase>();
  final FetchReconmendedJobsUseCase _fetchReconmendedJobsUseCase =
      GetIt.instance<FetchReconmendedJobsUseCase>();
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
  List<Company>? get companies => _companies;

  List<Recommendation> _reconmendation = [];
  List<Recommendation> get reconmendedjobs => _reconmendation;

  List<AppliedDatum> _appliedJobs = [];
  List<AppliedDatum> get appliedJobs => _appliedJobs;
  int _totalAppliedJob = 0;
  int get totalAppliedJob => _totalAppliedJob;


  List<JobData> _createdJobs = [];
  List<JobData> get createdJobs => _createdJobs;
  int _totalcreatedJob = 0;
  int get totalcreatedJob => _totalcreatedJob;

  void toggleGenerating(bool value) {
    if (jobhState.isGenerating == value) return;
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
        // ignore: unused_local_variable
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
      
        _lastPage = result.data?.jobs?.lastPage;
        final newJobs = result.data!.jobs!.data!
            .where((job) => !_jobs.contains(job))
            .toList();
        _jobs.addAll(newJobs);
        logger.d(_currentPage);
        _currentPage++;
        notifyListeners();
      },
    );
    
     await fetchAppliedjobs(context);
     notifyListeners();
    
  }

  Future<void> getSearchJobs(BuildContext context, String search,
      [int? page]) async {
    logger.d(page);
    toggleGenerating(true);
    notifyListeners();
    final result = await _fetchSearchJobsUseCase.call(search, page);
    toggleGenerating(false);
    result.fold(
      (exception) {
        // ignore: unused_local_variable
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          //AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        _lastPage = result.data?.jobs?.lastPage;
        final newJobs = result.data!.jobs!.data!
            .where((job) => !_jobs.contains(job))
            .toList();
        _jobs.clear();
        _jobs.addAll(newJobs);
        logger.d(_currentPage);
        _currentPage++;
        notifyListeners();
      },
    );
    fetchAppliedjobs(context, search:  search);
    searchReconmendedJobs(context, search);
    notifyListeners();
  }

  Future<void> get_reconmended_jobs(BuildContext context, [int? page]) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _fetchReconmendedJobsUseCase.call(page);
    toggleGenerating(false);
    result.fold(
      (exception) {
        // ignore: unused_local_variable
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          //AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        if (result.data == null) return;
        _reconmendation = result.data!.recommendation;
        _currentPage++;
        notifyListeners();
      },
    );
    notifyListeners();
  }


   Future<void> searchReconmendedJobs(BuildContext context, String search, [int? page]) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _fetchReconmendedJobsUseCase.call(page);
    toggleGenerating(false);
    result.fold(
      (exception) {
        // ignore: unused_local_variable
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
         // AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        if (result.data == null) return;
        _reconmendation = result.data!.recommendation.where((job) => job.title!.toLowerCase().contains(search.toLowerCase()),).toList();
        _currentPage++;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> fetchAppliedjobs(BuildContext context, {String? search = ''}) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _jobRepository.fetchAppliedJob();
    toggleGenerating(false);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        if (result.data == null) return;
        _appliedJobs = result.data!.applied!.data!.where((e) => e.job!.title!.toLowerCase().contains(search!.toLowerCase()) ).toList();
        _totalAppliedJob =result.data!.applied!.total?? 0;
        notifyListeners();
      },
    );
    notifyListeners();
  }


  Future<void> fetchCreatedjobs(BuildContext context, int? page, {String? search = ''}) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _jobRepository.fetchCreatedJobs(page);
    toggleGenerating(false);
    result.fold(
      (exception) {
        // ignore: unused_local_variable
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          //AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        if (result.data == null) return;
        _createdJobs = result.data!.hires!.data!.where((e) => e.title!.toLowerCase().contains(search!.toLowerCase()) ).toList();
        _totalcreatedJob =result.data!.hires?.total?? 0;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> registerCompany(
      AddCompanyDto payload, BuildContext context) async {
    showLoadingDialog(context: context);
    final result = await _jobRepository.addCompany(payload);
    Navigator.pop(context);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (value) async {
        if (context.mounted) {
          showDialog(
            barrierColor:
                Theme.of(context).colorScheme.brightness == Brightness.light
                    ? Colors.transparent.withOpacity(0.6)
                    : const Color(0xff110C00).withOpacity(0.8),
            context: context,
            builder: (context) {
              return SavedSuccess(
                message:
                    "Success! Your company details have been saved, and your job posting has been successfully posted. ",
              );
            },
          );

          // AppSnackbar.success(context, message: value.message ?? "Success!");
        }
      },
    );
    notifyListeners();
  }

  Future<void> createJob(AddJobDto payload, BuildContext context) async {
    showLoadingDialog(context: context);
    final result = await _jobRepository.addJob(payload);
    Navigator.pop(context);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (value) async {
        if (context.mounted) {
          showDialog(
            barrierColor:
                Theme.of(context).colorScheme.brightness == Brightness.light
                    ? Colors.transparent.withOpacity(0.6)
                    : const Color(0xff110C00).withOpacity(0.8),
            context: context,
            builder: (context) {
              return SavedSuccess(
                message: "Success! Your job have been created successfully.",
              );
            },
          );

          // AppSnackbar.success(context, message: value.message ?? "Success!");
        }
      },
    );
    fetchCreatedjobs(context, 1);
    getJobs(context);
    notifyListeners();
  }

  Future<void> getSavedCompanies(BuildContext context, int? page, {String? search = ''}) async {
    logger.d(page);

    toggleGenerating(true);
    notifyListeners();
    final result = await _jobRepository.fetchSavedCompanies(page);
    toggleGenerating(false);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        companies?.clear();
       var allcompanies = result.where((e) =>e.name!.toLowerCase().contains(search!.toLowerCase()) ,).toList();
        companies?.addAll(allcompanies);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> saveJob(
    String slug,
    BuildContext context,
  ) async {
    showLoadingDialog(context: context);
    final result = await _jobRepository.saveJob(slug);
    Navigator.pop(context);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (value) async {
        if (context.mounted) {
          AppSnackbar.success(context, message: value.message ?? "Success!");
        }
      },
    );
    notifyListeners();
  }
}
