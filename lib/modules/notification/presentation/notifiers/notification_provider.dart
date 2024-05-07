
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/entities/notification.entity.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/usecases/get_notification_use_cases.dart';
import 'package:analogue_shifts_mobile/modules/notification/presentation/notifiers/notification_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NotificationProvider extends ChangeNotifier {
  final FetchNotificationUseCase _fetchnotificationUseCase = GetIt.instance<FetchNotificationUseCase>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();



  final NotificationState _notificationState = NotificationState();

  NotificationState get notificationState => _notificationState;

  List<Datum> _notifications = [];
  List<Datum> get notifications => _notifications;

  void updateNotification(List<Datum> data) {
    logger.d('ruuning jobs data ${data}');
    _notifications.addAll(data);
    notifyListeners();
  }


  int _currentPage = 1;
  int get currentPage => _currentPage;
  int? _lastPage;
  int? get lastPage => _lastPage;

  void toggleGenerating(bool value) {
    if(notificationState.isGenerating == value)return;
    _notificationState.toggleGenerating();
    notifyListeners();
  }




  Future<void> getNotifications(BuildContext context, [int? page]) async {
    logger.d(page);
    toggleGenerating(true);
    notifyListeners();
    final result = await _fetchnotificationUseCase.call(page);
    toggleGenerating(false);
    result.fold(
          (exception) {
        var error = _errorHandler.handleError(exception);
        if(context.mounted){
          AppSnackbar.error(context, message: error);
        }

      },
          (result) async{
            logger.d('From Notification: ${result}');
            
            _lastPage = result.notifications?.lastPage;
            final newNotifications = result.notifications?.data.where((job) => !_notifications.contains(job)).toList();
            if (newNotifications == null)return;
            _notifications.addAll(newNotifications);
            // _notificationState.updateNotification(newNotifications);
      // _jobs.addAll(newJobs);
      
      logger.d(_currentPage);
      _currentPage++;
      notifyListeners();

      },
    );
    notifyListeners();
  }
}