import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/entities/notification.entity.dart';
import 'package:dartz/dartz.dart';

class NotificationState {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;





  void toggleGenerating() {
    _isGenerating = !_isGenerating;
  }
}