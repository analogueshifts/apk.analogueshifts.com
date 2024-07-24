
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/add_company.screen.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/post_a_job.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:googleapis/admob/v1.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(10),
              SvgPicture.asset("assets/images/Frame 482339.svg"),
              Gap(35),
              TextSemiBold("No jobs posted yet", fontSize: 18, fontWeight: FontWeight.w500, color: isLight ? AppColors.background : AppColors.white),
              Gap(10),
              TextSemiBold("Click the button at the bottom to post a job.", fontSize: 14, color: Color(0xff666666),),
              Gap(45),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCompanyScreen()
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.primaryColor
                      )
                  ),
                  child: TextSemiBold("Add company", color: AppColors.white, fontWeight: FontWeight.w700, textAlign: TextAlign.center,),
                ),
              ),
              Gap(20),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostAJobScreen()
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primaryColor
                    )
                  ),
                  child: TextSemiBold("Post a job", color: AppColors.primaryColor, fontWeight: FontWeight.w700, textAlign: TextAlign.center,),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
