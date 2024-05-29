import 'package:analogue_shifts_mobile/modules/notification/domain/entities/notification.entity.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class FetchNotificationUseCase {
  final NotificationRepository _notificationRepository = GetIt.instance<NotificationRepository>();


  Future<Either<Exception, NotificationEntity>> call([int? page]) async {
    return await _notificationRepository.fetchNotifications(page);
  }
}