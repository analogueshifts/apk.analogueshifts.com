import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/message/data/model/user_search_response.dart';
import 'package:analogue_shifts_mobile/modules/message/presentation/change_notifier/message_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserSearchBottomSheet extends StatefulWidget {
  final ScrollController? scrollController;

  const UserSearchBottomSheet({super.key, this.scrollController});

  @override
  State<UserSearchBottomSheet> createState() => _UserSearchBottomSheetState();
}

class _UserSearchBottomSheetState extends State<UserSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<UserDetail> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_onSearchChanged);
  }

  _fetchUsers() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var model = Provider.of<MessageProvider>(context, listen: false);
      model.fetchUsers(context);
      setState(() {
        // Initially display all users
      _filteredUsers = model.allUsers;
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    var model = Provider.of<MessageProvider>(context, listen: false);
    model.fetchSearchUsers(context, query);
    setState(() {
      _filteredUsers = model.allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLightMode = Theme.of(context).brightness == Brightness.light;
    return Consumer<MessageProvider>(
      builder: (context, model, child) {
        return SingleChildScrollView(
          controller: widget.scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryGrey2)),
                      child: const Icon(Icons.close_outlined),
                    ),
                  ),
                ),
                const Gap(15),
                // Search Field
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: textInputDecoration.copyWith(
                      fillColor: isLightMode ? AppColors.white : AppColors.background,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isLightMode
                              ? const Color(0xff000000).withAlpha(20)
                              : const Color(0xffFFFFFF).withAlpha(46),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isLightMode
                              ? const Color(0xff000000).withAlpha(20)
                              : const Color(0xffFFFFFF).withAlpha(46),
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: isLightMode
                            ? const Color(0xff000000).withAlpha(25)
                            : const Color(0xffFFFFFF).withAlpha(102),
                      ),
                      hintText: "Search users...",
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // If the data is still loading, display shimmer placeholders.
                if (model.messageState.isGenerating)
                  Shimmer.fromColors(
                    baseColor: isLightMode ? Colors.grey.shade300 : Colors.grey.shade700,
                    highlightColor: isLightMode ? Colors.grey.shade100 : Colors.grey.shade500,
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
                  // Display the filtered users list when data is available.
                  _filteredUsers.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _filteredUsers.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 0.2,
                            color: AppColors.primaryGrey2,
                            thickness: 0.2,
                          ),
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: user.userProfile?.avatar == null
                                  ? SvgPicture.asset(
                                      "assets/images/user-avatar.svg",
                                      width: 40,
                                      height: 40,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl: user.userProfile!.avatar!,
                                        width: 45,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            SvgPicture.asset(
                                          "assets/images/user-avatar.svg",
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                              title: Text(
                                '${user.userProfile?.lastName ?? ''} ${user.userProfile?.firstName ?? ''}'.trim(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isLightMode ? AppColors.background : AppColors.white,
                                ),
                              ),
                              subtitle: TextSemiBold(
                                user.email ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context, user);
                              },
                            );
                          },
                        )
                      : const Text('No users found.'),
              ],
            ),
          ),
        );
      },
    );
  }
}
