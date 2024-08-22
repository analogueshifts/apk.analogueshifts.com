
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/step.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/companies_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/countries_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/job_field_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/job_roles.bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/qualification_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';

class PostAJobScreen extends StatefulWidget {
  const PostAJobScreen({super.key});

  @override
  State<PostAJobScreen> createState() => _PostAJobScreenState();
}

class _PostAJobScreenState extends State<PostAJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyName = TextEditingController();
  final _positionTitle = TextEditingController();
  final _location = TextEditingController();
  final _jobField = TextEditingController();
  final _qualifiication = TextEditingController();
  final _companyWebsite = TextEditingController();
  final _companyLogoImage = TextEditingController();
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Post a Job"),
      body: Container(
        child:
          _currentPage == 1 ? _buildStep1() : _currentPage == 2 ? _buildStep2() : _buildStep3()

      ),
    );
  }

  Widget _buildStep1(){
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return  Consumer<JobProvider>(
        builder: (_, job, __) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gap(10),
              Center(child: TextSemiBold("To post a job kindly fill in job details below", fontSize: 14, color: Color(0xff666666),)),
              Gap(10),
              StepIndicator(currentStep: 1, totalSteps: 3),

              Gap(30),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Company Name', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),

              InkWell(
                onTap: () async{
                  job.getSavedCompanies(context);
                  final results = await showModalBottomSheet(
                      context: context,
                      builder:(context) {
                       return CompaniesBottomSheet();

                      }
                  );

                  if(results != null){
                    setState(() {
                      _companyName.text = results;
                    });

                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  width: double.infinity,
                  // height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5E5E5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSemiBold(_companyName.text.isEmpty ? "Company Name" : _companyName.text,color:isLight ? Color(0xff000000).withOpacity(_companyName.text.isEmpty ? 0.40 : 0.9) : AppColors.grey,),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(15),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Position title', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              InkWell(
                onTap: () async{
                 final results = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:(context) {
                        return JobRoleBottomSheet();
                      }
                  );

                 if(results != null){
                   setState(() {
                     _positionTitle.text = results;
                   });

                 }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  width: double.infinity,
                  // height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5E5E5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSemiBold(_positionTitle.text.isEmpty ? "Job role title" : _positionTitle.text, color: isLight ? Color(0xff000000).withOpacity(_positionTitle.text.isEmpty ? 0.40 : 0.90) : AppColors.grey),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Job Field', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              InkWell(
                onTap: () async{
                  final results = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:(context) {
                        return JobFieldBottomSheet();
                      }
                  );
                  if(results != null){
                    setState(() {
                      _jobField.text = results;
                    });

                  }
                },


                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  width: double.infinity,
                  // height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5E5E5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSemiBold(_jobField.text.isEmpty ? "Choose job’s field" : _jobField.text,color: isLight ? Color(0xff000000).withOpacity(_jobField.text.isEmpty ? 0.40 : 0.90) : AppColors.grey),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Qualification (optional) ', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),

                  ],
                ),
              ),
              const Gap(6),
              InkWell(
                onTap: () async{
                 final results = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:(context) {
                        return QualificationBottomSheet();
                      }
                  );
                 logger.d(results);

                 if(results != null){
                   setState(() {
                     _qualifiication.text = results!;
                   });

                 }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  width: double.infinity,
                  // height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5E5E5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSemiBold(_qualifiication.text.isEmpty ? "Choose expected qualification" : _qualifiication.text, color: isLight ? Color(0xff000000).withOpacity(_qualifiication.text.isEmpty ? 0.40 : 0.90) : AppColors.grey),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Job Location  (Country)', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              InkWell(
                onTap: () {
                  job.getSavedCompanies(context);
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:(context) {
                        return CountriesBottomSheet();
                      }
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  width: double.infinity,
                  // height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5E5E5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSemiBold("Choose expected qualification", color: isLight ? Color(0xff000000).withOpacity(0.40) : AppColors.grey,),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(20),
              BusyButton(title: "Next", onTap:(){}),
              Gap(30)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep2(){
    return Container();
  }

  Widget _buildStep3(){
    return Container();
  }
  }

