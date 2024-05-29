import 'package:analogue_shifts_mobile/modules/notification/domain/entities/notification.entity.dart';
import 'package:dartz/dartz.dart';


abstract class NotificationRepository {
  Future<Either<Exception, NotificationEntity>> fetchNotifications([int? page]);
}