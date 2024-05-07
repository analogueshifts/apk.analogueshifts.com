import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/core/utils/extensions.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/home/data/model/job_model.dart';
import 'package:analogue_shifts_mobile/modules/notification/domain/entities/notification.entity.dart';
import 'package:analogue_shifts_mobile/modules/notification/presentation/notifiers/notification_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final List<RecentJob> _recentJob = [
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/moniepoint.png", title: "Software Engineer", description: "Moniepoint"),
    RecentJob(image: "assets/images/work-hotshift.png", title: "Data Analyst", description: "Hostshifts"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaylonyAppBarTwo(title: "Notification", backTap: () {
        Navigator.pop(context);
      },),
      body: Consumer<NotificationProvider>(
         builder: (context, NotificationProvider notification, child) {
          logger.d(notification.notifications);
          if(notification.notifications.isEmpty)return const Text("No Notification");
              Map<String, List<Datum>> groupedNotifications =
      groupBy(notification.notifications.toList(), (Datum notification) {
        String createdAtDate = DateFormat('yyyy-MM-dd').format(notification.createdAt!);
        return createdAtDate;
      });
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    itemCount: groupedNotifications.length,
    itemBuilder: (BuildContext context, int index) {
      String date = groupedNotifications.keys.elementAt(index);
      List<Datum> notificationsForDate = groupedNotifications[date]!;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextSemiBold(Functions.dateConverter(DateTime.parse(date)), color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : const Color(0xffFFFFFF).withOpacity(0.7),),
          const Gap(10),
          
          ...notificationsForDate.mapIndexed(
            (index, notification) => 
           _notificationCard(notification, index == notificationsForDate.length - 1)
          ),
        ],
      );
    },
  );
         }
      ),
    );
  }

   Widget _notificationCard(Datum data, bool isLast) {
    logger.d(isLast);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              data.image == null ? const Icon(Icons.notifications_active, size: 20,) : ClipOval(
                 child: CachedNetworkImage(
                   imageUrl: data.image,
                  //  width: 40.w,
                  //  height: 40.h,
                   fit: BoxFit.cover,
                   placeholder: (context, url) => const CircularProgressIndicator(),
                   errorWidget: (context, url, error) => const Icon(Icons.error, size: 20,),
                 ),
               ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextSemiBold(data.title.toString(), fontSize: 14,fontWeight: FontWeight.w600, style: Theme.of(context).textTheme.bodyLarge,),
            
                  TextSemiBold(data.message.toString(), style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,)
                ],
              )
            ],
          ),
        ),
        const Gap(10),
       isLast ? const Text("") :  Divider(color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffE4E4E4) : const Color(0xffFFFFFF).withOpacity(0.24), )
      ],
    );
  }
}