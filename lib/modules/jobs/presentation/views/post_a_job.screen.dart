
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/companies_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PostAJobScreen extends StatefulWidget {
  const PostAJobScreen({super.key});

  @override
  State<PostAJobScreen> createState() => _PostAJobScreenState();
}

class _PostAJobScreenState extends State<PostAJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyName = TextEditingController();
  final _companyIndustry = TextEditingController();
  final _location = TextEditingController();
  final _companyEmail = TextEditingController();
  final _companyPhone = TextEditingController();
  final _companyWebsite = TextEditingController();
  final _companyLogoImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Post a Job"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: TextSemiBold("To post a job kindly fill in job details below", fontSize: 14, color: Color(0xff666666),)),
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
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      builder:(context) {
                        return CompaniesBottomSheet();
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
                      TextSemiBold("Company Name",color: Color(0xff000000).withOpacity(0.40),),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(8),
              Gap(20),
              BusyButton(title: "Next", onTap:(){}),
              Gap(30)
            ],
          ),
        ),
      ),
    );
  }
  }

