import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/edit_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.brightness;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
          leading: TouchableOpacity(
          onTap: () {
             Scaffold.of(context).openDrawer();
          },
          child: Container(
              width: 20, height: 20,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: const Icon(Icons.menu)
          ),
        ),
        centerTitle: true,
        title: TextSemiBold("Profile", fontSize: 20, color: theme == Brightness.light ? AppColors.background : AppColors.white,),
        actions: const [
          NotificationIcon()
        ],
      ),
      body: Consumer<UserViewModel>(
        builder: (context, UserViewModel user, child) {
          final name = Functions.capitalize(user.authState.user?.firstName ?? "");
        // final splitName = name.split(' ');
        // final firstName = splitName[0];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: ListView(children: [
            const Gap(20),
            Row(
              children: [
                user.authState.user?.profile == null ? Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/avatar_image.png" : "assets/images/profile-black.png"), width: 45,height: 45,) : 
                ClipOval(
                  child: CachedNetworkImage(
                  imageUrl: user.authState.user?.profile ?? "",
                  width: 60.w,
                    height: 60.h,
                    placeholder: (context, url) => CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      minRadius: 50,
                      child: const CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error, size: 50,),
                  // placeholder: (context, url) => SizedBox(width: 40.w, height:30, child: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/avatar_image.png" : "assets/images/profile-black.png"), width: 45,height: 45,)),
                                ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBold("Hi!, $name", fontSize: 16, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17
                    ),),
                    TextSemiBold("${user.authState.user?.email}", color: AppColors.grey,)
                  ],
                )
              ],
            ),
            const Gap(30),
            _navCard(Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/avatar_image.png" : "assets/images/profile-black.png"), width: 45,height: 45,), "Edit Profile", () {
               Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen()
            ),
          );
             }),
            _navCard(Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/work.png" : "assets/images/work-black.png"), width: 45,height: 45,), "Jobs Applied", () { 
              Navigator.pushNamed(context, Routes.jobsApplied);
            }),
            _navCard(Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/settings.png" : "assets/images/settings-black.png"), width: 45,height: 45,), "Settings", () {
              Navigator.pushNamed(context, Routes.settings);
        
            }),
          ],),
        );
        }
      ),
    );
  }

  Widget _navCard(Widget icon, String name, VoidCallback onTap){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TouchableOpacity(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const Gap(8),
                 TextSemiBold(name, fontSize: 16, fontWeight: FontWeight.w700, style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: AppColors.grey,)

          ],
        ),
      ),
    );
  }
}
