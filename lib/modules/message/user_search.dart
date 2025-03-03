import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Example User model.
class User {
  final String id;
  final String name;
  final String avatarUrl;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.email,
  });
}

/// Dummy list of users. Replace with your API data as needed.
const List<User> dummyUsers = [
  User(
      id: '1',
      name: 'Alice Johnson',
      email: 'example@gmail.com',
      avatarUrl: 'https://via.placeholder.com/150'),
  User(
      id: '2',
      name: 'Bob Smith',
      email: 'example@gmail.com',
      avatarUrl: 'https://via.placeholder.com/150'),
  User(
      id: '3',
      name: 'Charlie Brown',
      email: 'example@gmail.com',
      avatarUrl: 'https://via.placeholder.com/150'),
  User(
      id: '4',
      name: 'Diana Prince',
      email: 'example@gmail.com',
      avatarUrl: 'https://via.placeholder.com/150'),
];

/// A modal bottom sheet widget that allows searching for users.
/// User results are displayed only when the search field is not empty.
class UserSearchBottomSheet extends StatefulWidget {
  /// The scroll controller provided by the DraggableScrollableSheet.
  final ScrollController? scrollController;

  const UserSearchBottomSheet({super.key, this.scrollController});

  @override
  State<UserSearchBottomSheet> createState() => _UserSearchBottomSheetState();
}

class _UserSearchBottomSheetState extends State<UserSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers = [];
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  /// Filters the dummy users based on the search query.
  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredUsers = query.isEmpty
          ? []
          : dummyUsers.where((user) {
              return user.name.toLowerCase().contains(query);
            }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLightMode = Theme.of(context).brightness == Brightness.light;
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
                  child: Icon(Icons.close_outlined),
                ),
              ),
            ),
            Gap(15),
            // Search Field
            SizedBox(
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
                          ? const Color(0xff000000).withOpacity(0.08)
                          : const Color(0xffFFFFFF).withOpacity(0.18),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                  hintText: "Search users...",
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Display results only when the search field is not empty.
            if (_searchController.text.trim().isNotEmpty)
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
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
                          title: Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 14,
                              color: isLightMode
                                  ? AppColors.background
                                  : AppColors.white,
                            ),
                          ),
                          subtitle: TextSemiBold(
                            user.email,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          onTap: () {
                            // Return the selected user and close the sheet.
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
  }
}

// /// Example function to show the user search bottom sheet.
// /// The bottom sheet will initially expand to 70% of the screen height.
// void showUserSearchBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (context) {
//       return DraggableScrollableSheet(
//         initialChildSize: 0.7, // 70% of screen height
//         minChildSize: 0.7,
//         maxChildSize: 0.9,
//         expand: false,
//         builder: (context, scrollController) {
//           return UserSearchBottomSheet(scrollController: scrollController);
//         },
//       );
//     },
//   ).then((selectedUser) {
//     if (selectedUser != null && selectedUser is User) {
//       // Handle the selected user as needed.
//       debugPrint('Selected user: ${selectedUser.name}');
//     }
//   });
// }
