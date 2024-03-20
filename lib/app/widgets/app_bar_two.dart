import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:flutter/material.dart';
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';

class PaylonyAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  const PaylonyAppBarTwo({
    Key? key,
    required this.title,
    this.actions = const [],
    this.centerTitle = true,
    this.elevation,
    this.titleColor,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final bool centerTitle;
  final double? elevation;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      // backgroundColor: Color(0xffFBFBFB),
      // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColors.white, statusBarIconBrightness: Brightness.dark),
      leading: TouchableOpacity(
        onTap: () => Navigator.pop(context),
        child: const AppBackButton(),
      ),
      title: TextBold(
        title,
        fontSize: 18,
        color: titleColor ?? AppColors.background,
      ),
      actions: actions,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}