
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

class QualificationBottomSheet extends StatefulWidget {
  const QualificationBottomSheet({super.key});

  @override
  State<QualificationBottomSheet> createState() => _QualificationBottomSheetState();
}

class _QualificationBottomSheetState extends State<QualificationBottomSheet> {

  final _search = TextEditingController();

  JobRole? _rolesList;

  List<JobRole> filteredQualifications = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredQualifications = qualifications;
  }

  void filterSearchResults(String query) {
    List<JobRole> dummySearchList = [];
    dummySearchList.addAll(fields);
    if (query.isNotEmpty) {
      List<JobRole> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredQualifications = [];
        filteredQualifications.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredQualifications = [];
        filteredQualifications = roles;
      });
    }
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
                        TextSemiBold("Qualification", fontSize: 20,),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assets/icons/close-icon.svg"))
                      ],
                    ),
                    Gap(20),
                    filteredQualifications.isEmpty ? Center(child: Text("No Qualifications!"),) :
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
