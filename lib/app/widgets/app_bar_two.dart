import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:flutter/material.dart';

class PaylonyAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  const PaylonyAppBarTwo({
    super.key,
    required this.title,
    this.actions = const [],
    this.centerTitle = true,
    this.elevation,
    this.titleColor,
    this.backTap
  });

  final String title;
  final List<Widget> actions;
  final bool centerTitle;
  final double? elevation;
  final Color? titleColor;
  final VoidCallback? backTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leading: TouchableOpacity(
        onTap: backTap ?? () => Navigator.pop(context),
        child: const AppBackButton(),
      ),
      title: TextBold(
        title,
        style: Theme.of(context).textTheme.titleLarge,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      actions: actions,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
