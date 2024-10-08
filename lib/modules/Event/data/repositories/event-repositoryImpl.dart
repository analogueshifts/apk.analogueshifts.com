import 'dart:convert';
import 'dart:io';
import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/network/network_info.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/Event/data/models/create-event.dto.dart';
import 'package:analogue_shifts_mobile/modules/Event/domain/entities/event.entity.dart';
import 'package:analogue_shifts_mobile/modules/Event/domain/repositories/event-repository.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/no_data.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class EventRepositoryImpl implements EventRepository  {
  late DioManager dioManager;
  final DeviceNetwork _deviceNetwork = GetIt.instance<DeviceNetwork>();

  final _db = getIt<DBService>();
  EventRepositoryImpl(this.dioManager);

  @override
  Future<Either<Exception, NoDataResponse>> createEvent(CreateEventDto payload) async {
    try {
      if (await _deviceNetwork.isConnected() == false) {
        throw const SocketException('Network Error');
      }

      final response = await dioManager.dio.post(
          'tools/event/create',
          data: payload.toJson()
      );
      logger.d(response.data);
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        logger.d(response.data);
        logger.d(response.data[0]);
        final results = NoDataResponse.fromJson(response.data);
        return Right(results);
      } else {
        throw Exception('Event creation failed');
      }
    } on DioException catch (e) {
      logger.d(e.response?.data);
      logger.e(e);
      return Left(e);
    }catch(e){
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Event>>> getEvents([int? page]) async {
    try {
      final response = await dioManager.dio.get('tools/event');
      // logger.d(response.data);

      if (response.statusCode == 200) {
        logger.d(response.data['data']['events']['data']);
        final List<dynamic> data = response.data['data']['events']['data'];
        final List<Event> results = data.map((json) => Event.fromJson(json)).toList();
        return Right(results);
      } else {
        return Left(Exception('Unable to fetch events'));
      }
    } catch (e) {
      logger.e(e);
      return Left(Exception(e));
    }
  }


  @override
  Future<Either<Exception, List<Event>>> getUpcomingEvents([int? page]) async {
    try {
      final response = await dioManager.dio.get('event');
      // logger.d(response.data);

      if (response.statusCode == 200) {
        logger.d(response.data['data']['events']['data']);
        final List<dynamic> data = response.data['data']['events']['data'];
        final List<Event> results = data.map((json) => Event.fromJson(json)).toList();
        return Right(results);
      } else {
        return Left(Exception('Unable to fetch events'));
      }
    } catch (e) {
      logger.e(e);
      return Left(Exception(e));
    }
  }
}