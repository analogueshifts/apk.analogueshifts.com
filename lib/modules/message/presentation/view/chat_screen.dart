// ignore_for_file: unreachable_switch_default, depend_on_referenced_packages

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/message/presentation/change_notifier/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../data/model/single_chat_response .dart';

enum MessageType { text, image, audio, link }

class ChatScreen extends StatefulWidget {
  final String chatUuid;
  final String userName;
  final String userID;
  const ChatScreen({
    super.key,
    required this.chatUuid,
    required this.userName,
    required this.userID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  // This holds the current chat id. It may be null or empty if no chat exists yet.
  String? _currentChatUuid;

  @override
  void initState() {
    super.initState();
    // Use the passed chatUuid (could be empty when starting a new chat)
    _currentChatUuid = widget.chatUuid;
    _fetchChatDetail();
  }

  void _fetchChatDetail() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only attempt to fetch details if a valid chat id exists.
      if (_currentChatUuid != null && _currentChatUuid!.isNotEmpty) {
        Provider.of<MessageProvider>(context, listen: false)
            .showChatDetail(context, _currentChatUuid!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TouchableOpacity(
          onTap: () => Navigator.pop(context),
          child: const AppBackButton(),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/user-avatar.svg",
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextBold(
                widget.userName,
                color: Theme.of(context).colorScheme.brightness == Brightness.light
                    ? AppColors.background
                    : AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Message list.
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (context, model, child) {
                // If no valid chat id exists, show an empty message view.
                if (_currentChatUuid == null || _currentChatUuid!.isEmpty) {
                  return const SizedBox();
                }
                if (model.chatData == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                // If the provider returns a valid chat ID, update _currentChatUuid.
                if (model.chatData?.chatDetails?.uuid != null &&
                    model.chatData!.chatDetails!.uuid!.isNotEmpty &&
                    _currentChatUuid != model.chatData!.chatDetails!.uuid) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _currentChatUuid = model.chatData!.chatDetails!.uuid;
                    });
                  });
                }
                final messages = model.chatData!.messages?.data ?? [];
                // Sort messages descending by creation time (newest first).
                final sortedMessages = List<ChatMessage>.from(messages)
                  ..sort((a, b) {
                    final DateTime aTime = a.createdAt?? DateTime.now();
                    final DateTime bTime = b.createdAt ?? DateTime.now();
                    return bTime.compareTo(aTime);
                  });
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: sortedMessages.length,
                  itemBuilder: (context, index) {
                    final msg = sortedMessages[index];
                    return _buildMessageBubble(msg);
                  },
                );
              },
            ),
          ),
          // Input field and send button.
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        controller: _controller,
                        decoration: textInputDecoration.copyWith(
                          fillColor: Theme.of(context).brightness == Brightness.light
                              ? AppColors.white
                              : AppColors.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xff000000).withOpacity(0.08)
                                  : const Color(0xffFFFFFF).withOpacity(0.18),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xff000000).withOpacity(0.08)
                                  : const Color(0xffFFFFFF).withOpacity(0.18),
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).brightness == Brightness.light
                                ? const Color(0xff000000).withOpacity(0.1)
                                : const Color(0xffFFFFFF).withOpacity(0.4),
                          ),
                          hintText: "Type your messages...",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: _handleSend,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 22,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single message bubble.
  Widget _buildMessageBubble(ChatMessage msg) {
    final userModel = Provider.of<UserViewModel>(context);
    final currentUserId = userModel.authState.user?.user?.uuid?.trim();
    final bool isMe = msg.userUuid == currentUserId;
    final String content = msg.message ?? "";
    final DateTime time = msg.createdAt ?? DateTime.now();
    final MessageType type = MessageType.text;

    final bubbleColor = isMe
        ? AppColors.primaryColor
        : AppColors.placeholderColor.withOpacity(0.7);
    final textColor = isMe ? Colors.white : Colors.black87;

    Widget mainContent;
    switch (type) {
      case MessageType.image:
        mainContent = ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            content,
            width: 200,
            fit: BoxFit.cover,
          ),
        );
        break;
      case MessageType.audio:
        mainContent = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.audiotrack, size: 20),
            const SizedBox(width: 4),
            Text('Audio message', style: TextStyle(color: textColor)),
          ],
        );
        break;
      case MessageType.link:
        mainContent = Text(
          content,
          style: TextStyle(
            color: AppColors.primaryBlue,
            decoration: TextDecoration.underline,
          ),
        );
        break;
      case MessageType.text:
      default:
        mainContent = TextSemiBold(
          content,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        );
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            mainContent,
            const SizedBox(height: 4),
            Text(
              _formatTime(time),
              style: TextStyle(
                color: textColor.withOpacity(isMe ? 0.9 : 0.4),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formats a DateTime into a time string.
  String _formatTime(DateTime time) {
    return TimeOfDay.fromDateTime(time).format(context);
  }

  /// Handles sending a message.
  void _handleSend() async {
    final model = Provider.of<MessageProvider>(context, listen: false);
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    // Pass the current chat ID (which may be null or empty if starting a new chat)
    await model.creatChat(text, '', '', widget.userID, _currentChatUuid, context);
    _controller.clear();
  }
}
