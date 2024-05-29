import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.brightness;
    return InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.notification),
      child: Container(
        padding: EdgeInsets.only(right: 15),
        child: SvgPicture.asset(theme == Brightness.light ? "assets/icons/Bell.svg" : "assets/icons/Bell-light.svg")));
  }
}