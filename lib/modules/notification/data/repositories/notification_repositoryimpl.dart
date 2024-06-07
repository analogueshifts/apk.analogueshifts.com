import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/entities/notification.entity.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  late DioManager dioManager;

  NotificationRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, NotificationEntity>> fetchNotifications([int? page]) async {
    try {
      final response = await dioManager.dio.get('notification/view?page=${page ?? 1}');
      // logger.d(response.data);

      if (response.statusCode == 200) {
        logger.d(response.data);
        final notifcation_model = NotificationEntity.fromJson(response.data['data']);
        return Right(notifcation_model);
      } else {
        return Left(Exception('Error in fetching notifications'));
      }
    } catch (e) {
      logger.e(e);
      return Left(e as Exception);
    }
  }
}