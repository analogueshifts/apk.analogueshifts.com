import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/core/constants/date.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/message/chat_screen.dart';
import 'package:analogue_shifts_mobile/modules/message/user_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

/// A model representing a single message item.
class MessageItem {
  final String avatarUrl;
  final String displayName;
  final String handle;
  final String snippet;
  final String timestampLabel;
  final bool isMuted;
  final int unreadCount;

  const MessageItem({
    required this.avatarUrl,
    required this.displayName,
    required this.handle,
    required this.snippet,
    required this.timestampLabel,
    this.isMuted = false,
    this.unreadCount = 0,
  });
}

/// A screen that displays a list of direct messages with filtering options.
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  /// Sample list of messages; replace or fetch dynamically as needed.
  final List<MessageItem> _messages = const [
    MessageItem(
      avatarUrl: 'https://via.placeholder.com/80?text=John+U',
      displayName: 'John Uche',
      handle: '@johnrecruit',
      snippet: 'You: Alright',
      timestampLabel: '2025-03-03T13:29:06.000000Z',
    ),
    MessageItem(
      avatarUrl: 'https://via.placeholder.com/80?text=A',
      displayName: 'Ayomide Ike',
      handle: '@Ayomide',
      snippet: 'Please use the link to join the meet..',
      timestampLabel: '2025-03-03T09:23:37.000000Z',
      unreadCount: 2,
    ),
    MessageItem(
      avatarUrl: 'https://via.placeholder.com/80?text=D',
      displayName: 'Derek White',
      handle: '@Derek',
      snippet: 'You: Thank you.',
      timestampLabel: '2025-03-01T13:29:06.000000Z',
      isMuted: true,
    ),
    MessageItem(
      avatarUrl: 'https://via.placeholder.com/80?text=E',
      displayName: 'Emma Johnson',
      handle: '@Emmaj',
      snippet: 'Can we reschedule our meeting to...',
      timestampLabel: '2025-03-03T09:23:37.000000Z',
    ),
    MessageItem(
      avatarUrl: 'https://via.placeholder.com/80?text=M',
      displayName: 'Michael Smith',
      handle: '@michaelsmith',
      snippet: 'I’ll send you the documents by end of...',
      timestampLabel: '2025-03-02T13:29:06.000000Z',
      unreadCount: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: const PaylonyAppBarTwo(title: "Message"),

      // Main content
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildSearchBar()),
                  Gap(10),
                  _searchUserButton()
                ],
              ),
              const SizedBox(height: 16),
              _buildMessagesList(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the search bar widget.
  Widget _buildSearchBar() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        //controller: _search,
        decoration: textInputDecoration.copyWith(
          fillColor:
              Theme.of(context).colorScheme.brightness == Brightness.light
                  ? AppColors.white
                  : AppColors.background,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? const Color(0xff000000).withOpacity(0.08)
                      : const Color(0xffFFFFFF).withOpacity(0.18))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? const Color(0xff000000).withOpacity(0.08)
                      : const Color(0xffFFFFFF).withOpacity(0.18))),
          hintStyle: TextStyle(
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? const Color(0xff000000).withOpacity(0.1)
                      : const Color(0xffFFFFFF).withOpacity(0.4)),
          hintText: "Search",
        ),
      ),
    );
  }

  void showUserSearchBottomSheet(BuildContext context) {
   showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6, // 70% of screen height
        minChildSize: 0.6,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return UserSearchBottomSheet(scrollController: scrollController);
        },
      );
    },
    ).then((selectedUser) {
      if (selectedUser != null && selectedUser is User) {
        // Handle the selected user
        //debugPrint('Selected user: ${selectedUser.name}');
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          CupertinoPageRoute(
            builder: (_) => ChatScreen(),
          ),
        );
      }
    });
  }

  /// Builds a horizontal list of filter chips.
  Widget _searchUserButton() {
    return GestureDetector(
      onTap: () {
        showUserSearchBottomSheet(context);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: const Color(0xffFFFFFF),
          size: 30,
        ),
      ),
    );
  }

  /// Builds a ListView of message items, separated by a thin divider.
  Widget _buildMessagesList() {
    var isLightMode = Theme.of(context).brightness == Brightness.light;
    return ListView.separated(
      itemCount: _messages.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => Divider(
        height: 0.2,
        color: AppColors.primaryGrey2,
        thickness: 0.2,
      ),
      itemBuilder: (context, index) {
        final message = _messages[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(
            "assets/images/user-avatar.svg",
            width: 40,
            height: 40,
          ),
          title: Row(
            children: [
              Expanded(
                child: TextSemiBold(
                  message.displayName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isLightMode? AppColors.background: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              TextSemiBold(
                message.handle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          trailing: TextSemiBold(
            getDateGroupLabel(DateTime.parse(message.timestampLabel)),
            style: TextStyle(
              fontSize: 11,
              color: AppColors.grey,
            ),
          ),

          //getDateGroupLabel(DateTime date)

          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     // if (message.isMuted)
          //     //   const Padding(
          //     //     padding: EdgeInsets.only(right: 8.0),
          //     //     child: Icon(Icons.notifications_off_outlined, size: 18),
          //     //   ),
          //     // if (message.unreadCount > 0)
          //     //   Container(
          //     //     padding: const EdgeInsets.symmetric(
          //     //       horizontal: 6,
          //     //       vertical: 2,
          //     //     ),
          //     //     decoration: BoxDecoration(
          //     //       color: Colors.green,
          //     //       borderRadius: BorderRadius.circular(12),
          //     //     ),
          //     //     child: Text(
          //     //       message.unreadCount.toString(),
          //     //       style: const TextStyle(
          //     //         color: Colors.white,
          //     //         fontSize: 12,
          //     //       ),
          //     //     ),
          //     //   ),
          //   ],
          // ),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => ChatScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
