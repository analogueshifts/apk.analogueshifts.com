// ignore_for_file: unreachable_switch_default

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// A model for each chat message.
class ChatMessage {
  final String content;
  final bool isMe;
  final DateTime time;
  final MessageType type; // text, image, audio, link, etc.

  ChatMessage({
    required this.content,
    required this.isMe,
    required this.time,
    this.type = MessageType.text,
  });
}

enum MessageType { text, image, audio, link }

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      content: 'Can you develop a site like this?',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ChatMessage(
      content: 'Alright I will send you a meeting link for the interview',
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 28)),
    ),
    ChatMessage(
      content: 'Ok, Thank you',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    ChatMessage(
      content: 'assets/images/job-delete1.png', // Example local asset path
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 25)),
      type: MessageType.image,
    ),
    ChatMessage(
      content: 'My Resume',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    ChatMessage(
      content: 'assets/audio_placeholder.png', // or a real audio file reference
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      type: MessageType.audio,
    ),
    ChatMessage(
      content: 'Here: meet.google.com/fwc-bmq0-gsr',
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      type: MessageType.link,
    ),
    ChatMessage(
      content: 'Alright',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
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
            // CircleAvatar(
            //   radius: 18,
            //   backgroundColor: Colors.grey[300],
            //   backgroundImage: NetworkImage(
            //     'https://via.placeholder.com/150?text=John+U',
            //   ),
            // ),
            const SizedBox(width: 8),
            TextBold(
              'John Uche',
              style: Theme.of(context).textTheme.titleLarge,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),

      // Chat messages + input bar
      body: Column(
        children: [
          // List of messages
          Expanded(
            child: ListView.builder(
              reverse: true, // newest at the bottom
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Because we reversed, get item from the end
                final msg = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          // Input bar
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Input field
                  Expanded(
                    child: SizedBox(
                      height: 46,
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
                  // Send button
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

  /// Builds a single message bubble, with time displayed inside the bubble.
  Widget _buildMessageBubble(ChatMessage msg) {
    final bubbleColor = msg.isMe
        ? AppColors.primaryColor
        : AppColors.placeholderColor.withValues(alpha: 0.7);
    final textColor = msg.isMe ? Colors.white : Colors.black87;

    // Render the main content based on message type.
    Widget mainContent;
    switch (msg.type) {
      case MessageType.image:
        mainContent = ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            msg.content,
            width: 200,
            fit: BoxFit.cover,
          ),
        );
        break;
      case MessageType.audio:
        // Placeholder for audio UI
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
          msg.content,
          style: TextStyle(
            color: AppColors.primaryBlue,
            decoration: TextDecoration.underline,
          ),
        );
        break;
      case MessageType.text:
      default:
        mainContent = TextSemiBold(
          msg.content,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        );
        break;
    }

    // Stack to position the timestamp at the bottom-right inside the bubble.
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: msg.isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: msg.isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            // Space for the time at the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: mainContent,
            ),
            // Timestamp in the bottom-right corner
            Positioned(
              bottom: 0,
              right: 0 ,
              child: Text(
                _formatTime(msg.time),
                style: TextStyle(
                  color: textColor.withValues(alpha:  msg.isMe? 0.9: 0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formats the time (e.g., "14:11").
  String _formatTime(DateTime time) {
    return TimeOfDay.fromDateTime(time).format(context);
  }

  /// Handles sending a message.
  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          content: text,
          isMe: true,
          time: DateTime.now(),
        ),
      );
    });
    _controller.clear();
  }
}
