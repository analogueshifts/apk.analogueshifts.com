import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/modules/home/data/model/job_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          const Gap(15),
          TextSemiBold("NEW JOB ALERT",style:  Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600
          )),
          const Gap(7),
          Column(
            children: [
              Column(
                children: _recentJob.map((e) => _recentJobCard(e.image, e.title, e.description)).toList(),
              )
            ],
          ),
          const Gap(20),
          TextSemiBold("YESTERDAY",style:  Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600
          )),
          const Gap(7),
          Column(
            children: [
              Column(
                children: _recentJob.map((e) => _recentJobCard(e.image, e.title, e.description)).toList(),
              )
            ],
          ),
          const Gap(20),
          TextSemiBold("2/2/2024",style:  Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600
          )),
          const Gap(7),
          Column(
            children: [
              Column(
                children: _recentJob.map((e) => _recentJobCard(e.image, e.title, e.description)).toList(),
              )
            ],
          )
        ],
      ),
    );
  }

   Widget _recentJobCard(String image, String title, String description) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 40.h,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: AssetImage(image), width: 60, height: 40.h,),
          const Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSemiBold(title, fontSize: 14,fontWeight: FontWeight.w600, style: Theme.of(context).textTheme.bodyLarge,),
              TextSemiBold(description, style: Theme.of(context).textTheme.bodySmall,)
            ],
          )
        ],
      ),
    );
  }
}