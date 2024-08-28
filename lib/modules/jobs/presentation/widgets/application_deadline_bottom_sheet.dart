
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/jobs/data/data/job_role.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/job_role.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ApplicationBottomSheet extends StatefulWidget {
  const ApplicationBottomSheet ({super.key});

  @override
  State<ApplicationBottomSheet> createState() => _ApplicationBottomSheetState();
}

class _ApplicationBottomSheetState extends State<ApplicationBottomSheet> {

  List<JobRole> filteredQualifications = [];

  @override
  void initState() {
    super.initState();
    filteredQualifications = applicationDeadline;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(
      builder: (_, job, __) =>
          SingleChildScrollView(
            child: Container(
              height: screenHeight(context) * 0.8,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                            color: Color(0xffE7E7E7),
                            borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextSemiBold("OR Select Quickly", fontSize: 20,),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assets/icons/close-icon.svg"))
                      ],
                    ),
                    Gap(20),
                    filteredQualifications.isEmpty ? Center(child: Text("No Application Deadlinne!"),) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      filteredQualifications.map((e) =>
                          InkWell(
                            onTap: (){
                              Navigator.pop(context, e.name);
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: TextSemiBold(e.name.toString(), fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xff7B7B7B),)),
                          ),).toList(),
                    ),

                    Gap(15),
                    Gap(10),

                  ],
                ),
              ),
            ),
          ),
    );
  }
}
