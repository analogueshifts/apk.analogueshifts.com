
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

class JobRoleBottomSheet extends StatefulWidget {
  const JobRoleBottomSheet({super.key});

  @override
  State<JobRoleBottomSheet> createState() => _JobRoleBottomSheetState();
}

class _JobRoleBottomSheetState extends State<JobRoleBottomSheet> {

  final _search = TextEditingController();

  JobRole? _rolesList;

  List<JobRole> filteredRoles = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredRoles = roles;
  }

  void filterSearchResults(String query) {
    List<JobRole> dummySearchList = [];
    dummySearchList.addAll(roles);
    if (query.isNotEmpty) {
      List<JobRole> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredRoles = [];
        filteredRoles.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredRoles = [];
        filteredRoles = roles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
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
                        TextSemiBold("Position Title", fontSize: 20,),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assets/icons/close-icon.svg"))
                      ],
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _search,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          filterSearchResults(value.trim());
                        }
                      },
                      decoration: textInputDecoration.copyWith(
                          fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.08) : const Color(0xffFFFFFF).withOpacity(0.18)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.08) : const Color(0xffFFFFFF).withOpacity(0.18)
                              )
                          ),
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.1) : const Color(0xffFFFFFF).withOpacity(0.4)
                          ),
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color,)
                      ),
                    ),
                    const Gap(30),
                    filteredRoles.isEmpty ? Center(child: TextSemiBold("No Job Roles!"),) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      filteredRoles.map((e) =>
                          InkWell(
                            onTap: (){
                              Navigator.pop(context, e.name.toString());
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
