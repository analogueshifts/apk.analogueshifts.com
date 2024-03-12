import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:flutter/material.dart';

class PaylonyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PaylonyAppBar({
    Key? key,
    required this.title,
    this.elevation,
    this.actions = const [],
    this.centerTitle = false,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final double? elevation;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // backgroundColor: AppColors.white,
      // backgroundColor: Colors.transparent,
      title: TextBold(
        title,
        fontSize: 20,
        color: AppColors.textPrimaryColor,
        fontWeight: FontWeight.w700,
      ),
      actions: actions,
      elevation: elevation ?? 0.0,
      centerTitle: centerTitle,
      // foregroundColor: AppColors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}