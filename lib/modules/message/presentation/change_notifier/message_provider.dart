// ignore_for_file: use_build_context_synchronously

import 'package:analogue_shifts_mobile/core/network/api_errors.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/chat_api_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/single_chat_response%20.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/user_search_response.dart';
import 'package:analogue_shifts_mobile/modules/message/domain/repositories/message_repositories.dart';
import 'package:analogue_shifts_mobile/modules/message/presentation/change_notifier/message_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MessageProvider extends ChangeNotifier {
  final MessagesRepository _messagesRepository =
      GetIt.instance<MessagesRepository>();
  final ErrorHandler _errorHandler = GetIt.instance<ErrorHandler>();

  final MessageState _messageState = MessageState();

  MessageState get messageState => _messageState;

  final List<Chat> _chats = [];
  List<Chat> get chat => _chats;

  SingleChatData _chatData = SingleChatData();
  SingleChatData? get chatData => _chatData;

  final List<UserDetail> _allUsers = [];
  List<UserDetail> get allUsers => _allUsers;

  void toggleGenerating(bool value) {
    if (messageState.isGenerating == value) return;
    _messageState.toggleGenerating();
    notifyListeners();
  }

  Future<void> fetchAllUserChat(BuildContext context, [int? page]) async {
    logger.d(page);

    toggleGenerating(true);
    notifyListeners();
    final result = await _messagesRepository.fetchAllUserChat(page ?? 1);
    toggleGenerating(false);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        if (result.data != null) {
          for (final pagination in result.data!) {
            if (pagination.data != null) {
              _chats.clear();
              _chats.addAll(pagination.data!);
              notifyListeners();
            }
          }
        }
      },
    );
    notifyListeners();
  }

  Future<void> fetchSearchUsers(BuildContext context, String? search) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _messagesRepository.fetchSearchUsers(search ?? 'a');
    toggleGenerating(false);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        _allUsers.clear();
        // Safely access nested properties with null-aware operators
        _allUsers.addAll(result.data?.users?.data ?? []);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> fetchUsers(BuildContext context) async {
    toggleGenerating(true);
    notifyListeners();
    final result = await _messagesRepository.fetchUsers();
    toggleGenerating(false);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        _allUsers.clear();
        _allUsers.addAll((result.data?.users?.data ?? []).cast<UserDetail>());
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> showChatDetail(BuildContext context, String chatUuid) async {
    logger.d(chatUuid);
    toggleGenerating(true);
    notifyListeners();
    final result = await _messagesRepository.showChatDetail(chatUuid);
    toggleGenerating(false);
    result.fold(
      (exception) {
        var error = _errorHandler.handleError(exception);
        if (context.mounted) {
          AppSnackbar.error(context, message: error);
        }
      },
      (result) async {
        if (result.data != null) {
          _chatData = result.data!;
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }

  // Future<void> creatChat(String? message, dynamic mediafile, dynamic refuuid,
  //     dynamic useruuid, dynamic chatUuid, BuildContext context) async {
  //   final result = await _messagesRepository.creatChat(
  //       message, mediafile, refuuid, useruuid);
  //   result.fold(
  //     (exception) {
  //       var error = _errorHandler.handleError(exception);
  //       if (context.mounted) {
  //         AppSnackbar.error(context, message: error);
  //       }
  //     },
  //     (value) async {
  //       notifyListeners();
  //       await showChatDetail(context, chatUuid);
  //     },
  //   );
  // }


  Future<void> creatChat(String? message, dynamic mediafile, dynamic refuuid,
    dynamic useruuid, dynamic chatUuid, BuildContext context) async {
  final result = await _messagesRepository.creatChat(message, mediafile, refuuid, useruuid);
  result.fold(
    (exception) {
      var error = _errorHandler.handleError(exception);
      if (context.mounted) {
        AppSnackbar.error(context, message: error);
      }
    },
    (value) async {
      // If chatUuid is null or empty, try to get the new chat's ID from the response.
      String? effectiveChatUuid = chatUuid;
      if (effectiveChatUuid == null || effectiveChatUuid.toString().isEmpty) {
        if (value.data != null &&
            value.data!.chat != null &&
            value.data!.chat!.uuid!.isNotEmpty) {
          effectiveChatUuid = value.data!.chat!.uuid;
        }
      }
      notifyListeners();
      if (effectiveChatUuid != null && effectiveChatUuid.toString().isNotEmpty) {
        await showChatDetail(context, effectiveChatUuid);
      } else {
        // Optionally handle the case when no valid chat id is available.
      }
    },
  );
}

}
