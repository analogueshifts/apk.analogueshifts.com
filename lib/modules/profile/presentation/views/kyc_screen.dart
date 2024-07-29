
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/experience_level.bottom-sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/job_roles.bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/skills_bottom_field.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/years_of_experience_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {

  String? role;
  String? _level;
  String? _years;
  List<String> _skills = [];
  String? _skillError;
  String? _roleError;
  String? _experienceError;
  String? _levelError;

  bool _isValid = false;

  void updateFormState(){
    setState(() {
      if(role == null){
        _roleError = "Select your role";
      }

      if(_level == null){
        _levelError = " Select your experience level";
      }
      if(_years == null){
        _experienceError = "Select your years of experience";
      }
      if(_skills.isEmpty){
        _skillError = "Add a skill";
      }
      if(role != null){
        _roleError = null;
      }
      if(_level != null){
        _levelError = null;
      }
      if(_years != null){
        _experienceError = null;
      }
      if(_skills.isNotEmpty){
        _skillError = null;
      }
      if(role != null && _level != null && _years != null && _skills.isNotEmpty){
        _isValid = true;
      }else if(role != null || _level != null || _years != null || _skills.isEmpty){
        _isValid = false;
      }
      _isValid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    final theme = Theme.of(context).colorScheme.brightness;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: TextSemiBold("KYC", fontSize: 20, color: theme == Brightness.light ? AppColors.background : AppColors.white,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(6),
            TextSemiBold("This helps us tailor recommendations based on your role preferences.", fontSize: 14, fontWeight: FontWeight.w400, color: isLight ? const Color(0xff000000).withOpacity(0.6) : AppColors.grey,),
            const Gap(20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Role', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                ],
              ),
            ),
            const Gap(6),
            InkWell(
              onTap: () async{
                final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder:(context) {
                      return const JobRoleBottomSheet();
                    }
                );

                if (result != null) {
                  setState(() {
                    role = result;
                  });
                  updateFormState();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                width: double.infinity,
                // height: 56,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffE5E5E5)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextSemiBold(role ?? "Enter  your  preferred role", color: role != null ? isLight ? AppColors.background : AppColors.primaryGrey : isLight ? const Color(0xff000000).withOpacity(0.40) : AppColors.grey),
                    const Icon(Icons.keyboard_arrow_down)

                  ],
                ),
              ),
            ),
            TextSemiBold(_roleError ?? "", fontSize: 14, fontWeight: FontWeight.w400, color: _skillError != null ? Colors.red : isLight ? const Color(0xff000000).withOpacity(0.6) : AppColors.grey,),
            const Gap(20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Level of Experience', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                ],
              ),
            ),
            const Gap(6),
            InkWell(
              onTap: () async{
                final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder:(context) {
                      return const ExperienceLevelBottomSheet();
                    }
                );

                if (result != null) {
                  setState(() {
                    _level = result;
                  });
                  updateFormState();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                width: double.infinity,
                // height: 56,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffE5E5E5)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextSemiBold(_level ?? "Select your level of experience", color: _level != null ? isLight ? AppColors.background : AppColors.primaryGrey : isLight ? const Color(0xff000000).withOpacity(0.40) : AppColors.grey),
                    const Icon(Icons.keyboard_arrow_down)

                  ],
                ),
              ),
            ),
            TextSemiBold(_levelError ?? "", fontSize: 14, fontWeight: FontWeight.w400, color: _skillError != null ? Colors.red : isLight ? const Color(0xff000000).withOpacity(0.6) : AppColors.grey,),
            const Gap(20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Years of Experience', style: TextStyle(fontWeight: FontWeight.w700,fontFamily: AppFonts.manRope, color: isLight ? AppColors.background : AppColors.white,),),
                ],
              ),
            ),
            const Gap(6),
            InkWell(
              onTap: () async{
                final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder:(context) {
                      return const YearsExperienceBottomSheet();
                    }
                );

                if (result != null) {
                  setState(() {
                    _years = result;
                  });
                  updateFormState();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                width: double.infinity,
                // height: 56,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffE5E5E5)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextSemiBold(_years ?? "Select your years of experience", color: _years != null ? isLight ? AppColors.background : AppColors.primaryGrey : isLight ? const Color(0xff000000).withOpacity(0.40) : AppColors.grey),
                    const Icon(Icons.keyboard_arrow_down)

                  ],
                ),
              ),
            ),
            TextSemiBold(_experienceError ?? "", fontSize: 14, fontWeight: FontWeight.w400, color: _skillError != null ? Colors.red : isLight ? const Color(0xff000000).withOpacity(0.6) : AppColors.grey,),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextSemiBold("Your Skills", fontSize: 13, fontWeight: FontWeight.w600,),
                InkWell(
                    onTap: () async{
                      if(_skills.length == 12) {
                        setState(() {
                          _skillError = "Maximum Skill reached!";
                        });
                      }
                      final result = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder:(context) {
                            return const SkillsBottomSheet();
                          }
                      );

                      if (result != null) {
                        setState(() {
                          _skills = result;
                        });
                        updateFormState();
                      }
                    },
                    child: TextSemiBold("Add Skills", color: AppColors.primaryColor, fontSize: 13, fontWeight: FontWeight.w600,)),

              ],
            ),
            const Gap(6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffE5E5E5)),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: _skills.isEmpty ?
              InkWell(
                onTap: () async{
                  if(_skills.length == 12) {
                    setState(() {
                      _skillError = "Maximum Skill reached!";
                    });
                  }
                  final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:(context) {
                        return const SkillsBottomSheet();
                      }
                  );

                  if (result != null && result.length > 0) {
                    setState(() {
                      _skills = result;
                    });
                    updateFormState();
                  }
                },
                child: SizedBox(
                  height: screenHeight(context) * 0.16,
                  child: TextSemiBold("Select your years of experience", color: isLight ? const Color(0xff000000).withOpacity(0.40) : AppColors.grey),
                ),
              )
               :
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: _skills.map((e) =>
                    Container(
                      height: 30.h,
                      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: TextSemiBold(e, fontWeight: FontWeight.w300, color: AppColors.white,)),
                          Gap(3),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _skills.removeWhere((element) => element == e);
                              });
                              updateFormState();

                            },
                              child: const Icon(Icons.close, size: 24, color: AppColors.white,))
                        ],
                      ),
                    )
                ).toList(),
              ),
            ),
            const Gap(10),
            TextSemiBold(_skillError ?? "You can select a maximum of 12 skills.", fontSize: 14, fontWeight: FontWeight.w400, color: _skillError != null ? Colors.red : isLight ? const Color(0xff000000).withOpacity(0.6) : AppColors.grey,),
            const Gap(40),
            BusyButton(
                title: "Enter",
                onTap: (){
                  updateFormState();

            })
          ],
        ),
      ),


    );
  }
}
