// ignore: file_names

import 'package:analogue_shifts_mobile/core/network/api_client.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/chat_api_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/message_sent_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/single_chat_response%20.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/user_search_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/users_response.dart';
import 'package:analogue_shifts_mobile/modules/message/domain/repositories/message_repositories.dart';
import 'package:dartz/dartz.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  late DioManager dioManager;

  MessagesRepositoryImpl(this.dioManager);
  @override
  Future<Either<Exception, MessageSentResponse>> creatChat(
      String? message, mediafile, refuuid, useruuid) async {
    try {
      final response = await dioManager.dio.post('chat/$useruuid', data: {
        "message": message,
        "media_file": mediafile,
        "ref_uuid": refuuid,
      });

      if (response.statusCode == 200) {
        // logger.d(response.data);
        final results = MessageSentResponse.fromJson(response.data);
        return Right(results);
      } else {
        return Left(Exception('Unable to save chat'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, UserSearchResponse>> fetchSearchUsers(String? search,
      [int? page]) async {
    try {
      final response = await dioManager.dio.get(
        'users/find?search=$search',
      );

      if (response.statusCode == 200) {
        // logger.d(response.data);
        final jobModel = UserSearchResponse.fromJson(response.data);
        return Right(jobModel);
      } else {
        return Left(Exception('Unable to fetch user'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, ChatApiResponse>> fetchAllUserChat(
      [int? page]) async {
    try {
      final response = await dioManager.dio.get('chat/index?page=${page ?? 1}');
      // logger.d(response.data);

      if (response.statusCode == 200) {
        // logger.d(response.data);
        final jobModel = ChatApiResponse.fromJson(response.data);
        return Right(jobModel);
      } else {
        return Left(Exception('Unable to fetch user chat'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, SingleChatResponse>> showChatDetail(String chatUuid) async {
    try {
      final response = await dioManager.dio.get('chat/$chatUuid');
      // logger.d(response.data);

      if (response.statusCode == 200) {
        // logger.d(response.data);
        final jobModel = SingleChatResponse.fromJson(response.data);
        return Right(jobModel);
      } else {
        return Left(Exception('Unable to fetch user chat'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, AllUserResponse>> fetchUsers() async {
     try {
      final response = await dioManager.dio.get(
        'users',
      );

      if (response.statusCode == 200) {
        // logger.d(response.data);
        final jobModel = AllUserResponse.fromJson(response.data);
        return Right(jobModel);
      } else {
        return Left(Exception('Unable to fetch user'));
      }
    } catch (e) {
      logger.e(e);
      // var error = _errorHandler.handleError(e);
      return Left(Exception(e));
    }
  }
}
