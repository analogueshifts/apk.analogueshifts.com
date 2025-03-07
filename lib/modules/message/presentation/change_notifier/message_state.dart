import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/chat_api_response.dart';

class MessageState {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;
  List<ChatMessage>? _messages;
  List<ChatMessage>? get messages => _messages;
  // Job? get jobs => _jobs;

  void updateChat(List<ChatMessage> messages) {
    logger.d('ruuning message data $messages');
    _messages?.addAll(messages);
  }





  void toggleGenerating() {
    _isGenerating = !_isGenerating;
  }
}