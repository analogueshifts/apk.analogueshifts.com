import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/authenticate_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/edit_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: TouchableOpacity(
          onTap:(){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeNavigation()),
                    (Route<dynamic> route) => true);
          },
          child: const AppBackButton(),
        ),
        title: TextBold(""),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, UserViewModel user, child) {
          final name = Functions.capitalize(user.authState.user?.name ?? "");
        final splitName = name.split(' ');
        final firstName = splitName[0];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: ListView(children: [
            const Gap(20),
            Row(
              children: [
                user.authState.user?.profile == null ? Icon(Icons.verified_user) : CachedNetworkImage(
                imageUrl: user.authState.user?.profile ?? "",
                placeholder: (context, url) => SizedBox(width: 40.w, height:30, child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBold("Hi!, $firstName", fontSize: 16, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17
                    ),),
                    TextSemiBold("${user.authState.user?.email}", color: AppColors.grey,)
                  ],
                )
              ],
            ),
            const Gap(30),
            _navCard(const Image(image: AssetImage("assets/images/avatar_image.png"), width: 45,height: 45,), "Edit Profile", () {
               Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen()
            ),
          );
             }),
            _navCard(const Image(image: AssetImage("assets/images/work.png"), width: 45,height: 45,), "Jobs Applied", () { 
              context.goNamed('jobs-applied');
            }),
            _navCard(const Image(image: AssetImage("assets/images/settings.png"), width: 45,height: 45,), "Settings", () {
              context.goNamed("settings");
        
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
