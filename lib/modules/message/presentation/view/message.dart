// ignore_for_file: use_build_context_synchronously

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/chat_api_response.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/user_search_response.dart';
import 'package:analogue_shifts_mobile/modules/message/presentation/change_notifier/message_provider.dart';
import 'package:analogue_shifts_mobile/modules/message/presentation/view/chat_screen.dart';
import 'package:analogue_shifts_mobile/modules/message/presentation/view/user_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchChats();
    // Listen to changes in search text to trigger rebuild.
    _searchController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _fetchChats() async {
 WidgetsBinding.instance.addPostFrameCallback((_) async{

    await Provider.of<MessageProvider>(context, listen: false)
        .fetchAllUserChat(context);
  });}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Message"),
      body: SafeArea(
        // Wrap in RefreshIndicator for immediate update on pull-to-refresh.
        child: RefreshIndicator(
          onRefresh: _fetchChats,
          child: Consumer<MessageProvider>(
            builder: (context, model, child) {
              // Get the current list of chats from the provider.
              final allChats = model.chat;
              // Filter chats based on the search text.
              final filteredChats = _searchController.text.trim().isEmpty
                  ? allChats
                  : allChats.where((chat) {
                      if (chat.members != null && chat.members!.isNotEmpty) {
                        final member = chat.members!.first;
                        final fullName =
                            "${member.user?.userProfile?.firstName ?? ''} ${member.user?.userProfile?.lastName ?? ''}"
                                .toLowerCase();
                        return fullName.contains(
                            _searchController.text.trim().toLowerCase());
                      }
                      return false;
                    }).toList();

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Row containing search bar and a button to open user search.
                    Row(
                      children: [
                        Expanded(child: _buildSearchBar()),
                        const Gap(10),
                        _searchUserButton(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Show a loading indicator while chats are being fetched.
                    if (model.messageState.isGenerating)
                      Shimmer.fromColors(
                        baseColor:
                            isLightMode ? Colors.grey.shade300 : Colors.grey.shade700,
                        highlightColor:
                            isLightMode ? Colors.grey.shade100 : Colors.grey.shade500,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                              ),
                              title: Container(
                                height: 10,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 150,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      )
                    else
                      _buildMessagesList(filteredChats),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds a search bar widget.
  Widget _buildSearchBar() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: _searchController,
        decoration: textInputDecoration.copyWith(
          fillColor: Theme.of(context).brightness == Brightness.light
              ? AppColors.white
              : AppColors.background,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color(0xff000000).withValues(alpha: .08)
                  : const Color(0xffFFFFFF).withValues(alpha: .18),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color(0xff000000).withValues(alpha: .08)
                  : const Color(0xffFFFFFF).withValues(alpha: .18),
            ),
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xff000000).withValues(alpha: .1)
                : const Color(0xffFFFFFF).withValues(alpha: .4),
          ),
          hintText: "Search",
        ),
      ),
    );
  }

  /// A button that opens a bottom sheet to search for users.
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
        child: const Icon(
          Icons.add,
          color: Color(0xffFFFFFF),
          size: 30,
        ),
      ),
    );
  }

  /// Builds the ListView displaying chat items.
  Widget _buildMessagesList(List<Chat> chats) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    // Retrieve current user id.
    // ignore: unused_local_variable
    final currentUserId = Provider.of<UserViewModel>(context, listen: false)
        .authState
        .user
        ?.user
        ?.uuid
        ?.trim();
    return ListView.separated(
      itemCount: chats.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => Divider(
        height: 0.2,
        color: AppColors.primaryGrey2,
        thickness: 0.2,
      ),
      itemBuilder: (context, index) {
        final chat = chats[index];
        // For a one-to-one chat, display the first member's profile.
        final member = chat.members?.first;
        // Calculate the latest message by sorting the messages list.
        // ignore: unused_local_variable
        ChatMessage? latestMessage;
        if (chat.messages != null && chat.messages!.isNotEmpty) {
          final messages = List<ChatMessage>.from(chat.messages!);
          messages.sort((a, b) {
            final aTime = DateTime.tryParse(a.createdAt ?? '') ?? DateTime.now();
            final bTime = DateTime.tryParse(b.createdAt ?? '') ?? DateTime.now();
            return aTime.compareTo(bTime);
          });
          latestMessage = messages.last;
        }
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: member?.user?.userProfile?.avatar != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    member!.user!.userProfile!.avatar!,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                )
              : SvgPicture.asset(
                  "assets/images/user-avatar.svg",
                  width: 45,
                  height: 45,
                ),
          title: Text(
            '${member?.user?.userProfile?.firstName ?? ''}  ${member?.user?.userProfile?.lastName ?? ''}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isLightMode ? AppColors.background : AppColors.white,
            ),
            maxLines: 1,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member?.user?.email ?? '',
                style: TextStyle(fontSize: 12, color: AppColors.grey),
                maxLines: 1,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => ChatScreen(
                  chatUuid: chat.uuid!,
                  userName: '${member?.user?.userProfile?.firstName ?? ''}  ${member?.user?.userProfile?.lastName ?? ''}',
                  userID: member?.user?.uuid ?? '',
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Opens a bottom sheet to search for users.
  void showUserSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return UserSearchBottomSheet(scrollController: scrollController);
          },
        );
      },
    ).then((selectedUser) {
      if (selectedUser != null && selectedUser is UserDetail) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => ChatScreen(
              chatUuid: '',
              userName: selectedUser.userProfile?.firstName ?? '',
              userID: selectedUser.uuid ?? '',
            ),
          ),
        );
      }
    });
  }
}
