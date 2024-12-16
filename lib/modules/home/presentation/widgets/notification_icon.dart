import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/modules/notification/presentation/notifiers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.brightness;
    return Consumer<NotificationProvider>(
        builder: (context, NotificationProvider notification, child) =>
      InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.notification),
        child: Container(
          padding: const EdgeInsets.only(right: 15),
          child: notification.unviewedNotificationCount < 1 ? Icon(Icons.notifications) :  SvgPicture.asset(theme == Brightness.light ? "assets/icons/Bell.svg" : "assets/icons/Bell-light.svg")
        )
      ),
    );
  }
}