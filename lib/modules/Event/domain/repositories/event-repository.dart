import 'package:analogue_shifts_mobile/modules/Event/data/models/create-event.dto.dart';
import 'package:analogue_shifts_mobile/modules/Event/domain/entities/event.entity.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/views/events.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/forgetpaasswordcreate.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:dartz/dartz.dart';


abstract class EventRepository {
  Future<Either<Exception, NoDataResponse>> createEvent(CreateEventDto payload);
  Future<Either<Exception, List<Event>>> getEvents();
  Future<Either<Exception, List<Event>>> getUpcomingEvents();
}
