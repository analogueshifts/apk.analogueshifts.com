
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/usecases/fetch_job.usecase.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JobProvider extends ChangeNotifier {
  final FetchJobsUseCase _fetchJobsUseCase = GetIt.instance<FetchJobsUseCase>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();
  final _db = getIt<DBService>();



  final JobState _jobState = JobState();

  JobState get jobhState => _jobState;


  List<Datum> _jobs = [];
  List<Datum> get job => _jobs;
  int _currentPage = 1;
  int get currentPage => _currentPage;
  int? _lastPage;
  int? get lastPage => _lastPage;

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
}