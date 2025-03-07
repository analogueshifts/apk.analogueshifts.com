
import 'package:analogue_shifts_mobile/modules/message/data/model/chat_api_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/message_sent_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/single_chat_response%20.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/user_search_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/users_response.dart';
import 'package:dartz/dartz.dart';


abstract class MessagesRepository {
  Future<Either<Exception, MessageSentResponse>> creatChat(String? message,  mediafile, refuuid,useruuid );
  Future<Either<Exception, UserSearchResponse>> fetchSearchUsers(String? search, [int? page]);
  Future<Either<Exception, AllUserResponse>> fetchUsers();
  Future<Either<Exception, ChatApiResponse>> fetchAllUserChat([int? page]);
  Future<Either<Exception, SingleChatResponse>> showChatDetail(String chatUuid);
}