
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CompaniesBottomSheet extends StatefulWidget {
  const CompaniesBottomSheet({super.key});

  @override
  State<CompaniesBottomSheet> createState() => _CompaniesBottomSheetState();
}

class _CompaniesBottomSheetState extends State<CompaniesBottomSheet> {

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
      return Consumer<JobProvider>(
        builder: (_, job, __) =>
        Wrap(
          children: [
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 5.h,
                        margin: EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: isLight ? Color(0xffE7E7E7) : AppColors.white,
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextSemiBold("Companies", fontSize: 20,),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                            child: SvgPicture.asset("assets/icons/close-icon.svg"))
                      ],
                    ),
                    Gap(30),
                    job.companies.isEmpty && job.jobhState.isGenerating ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)) : job.companies.isEmpty ? Center(child: TextSemiBold("No Companies!"),) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      job.companies.map((e) =>
                          TouchableOpacity(
                            onTap: (){
                              Navigator.pop(context, e.name.toString());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                                child: TextSemiBold(e.name.toString(), fontWeight: FontWeight.w400, fontSize: 15, color: isLight ? Color(0xff7B7B7B) : Color(0xff7B7B7B).withOpacity(0.8),)),
                          ),).toList(),
                    ),

                    Gap(15),
                    Gap(10),

                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}
