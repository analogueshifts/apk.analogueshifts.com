import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../views/home_navigation.dart';

class JobAnalyticsCard extends StatelessWidget {
  const JobAnalyticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final job = Provider.of<JobProvider>(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSemiBold(
                "Job Analytics",
                color: AppColors.white,
                fontSize: 14,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     TextSemiBold(
              //       "Job summary",
              //      // "This Week",
              //       color: AppColors.white,
              //       fontSize: 14,
              //     ),
              //     // InkWell(
              //     //   onTap: () {},
              //     //   child: Icon(
              //     //     Icons.keyboard_arrow_down_rounded,
              //     //     color: AppColors.white,
              //     //   ),
              //     // )
              //   ],
              // )
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/elements.svg"),
                  Gap(10),
                  TextSemiBold(
                    job.totalAppliedJob.toString(),
                    fontSize: 32,
                    color: AppColors.white,
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/elements.svg"),
                          Gap(10),
                          TextSemiBold(
                            job.totalcreatedJob.toString(),
                            fontSize: 32,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap(20),
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeNavigation(
                                            selectedIndex: 1, fromHome: false),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSemiBold("Jobs Applied",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white.withOpacity(0.64)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSemiBold("Jobs Posted",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white.withOpacity(0.64)),
                  Gap(50),
                  Text("")
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
