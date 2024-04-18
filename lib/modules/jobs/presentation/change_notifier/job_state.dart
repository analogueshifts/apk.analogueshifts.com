import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:dartz/dartz.dart';

class JobState {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;
  List<Job>? _jobs;
  List<Job>? get jobs => _jobs;
  // Job? get jobs => _jobs;

  void updateJobs(List<Job> jobs) {
    logger.d('ruuning jobs data ${jobs}');
    if(jobs == null)return;
    _jobs?.addAll(jobs);
  }





  void toggleGenerating() {
    _isGenerating = !_isGenerating;
  }
}