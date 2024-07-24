
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/logo-image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
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
      appBar: const PaylonyAppBarTwo(title: "Add Company"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: TextSemiBold("Quickly add the company's information.", fontSize: 14, color: Color(0xff666666),)),
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
              TextFormField(
                controller: _companyName,
                // controller: _emailController,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'Company Name'),
                validator: (value) {
                  if (value == null) return ("Enter your company name");
          
                  return null;
                },
                onChanged: (value) {
                },
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Company Industry', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              TextFormField(
                controller: _companyIndustry,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'Job role title'),
                validator: (value) {
                  if (value == null) return ("Enter Job role title");
          
                  return null;
                },
                onChanged: (value) {
                },
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Location', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              TextFormField(
                controller: _location,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'Choose job’s location'),
                validator: (value) {
                  if (value == null) return ("Enter Job location");
          
                  return null;
                },
                onChanged: (value) {
                },
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Company Email Address', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              TextFormField(
                controller: _location,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'Choose job’s email'),
                validator: (value) {
                  if (value == null) return ("Enter company email");
          
                  return null;
                },
                onChanged: (value) {
                },
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Company Phone Number', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              TextFormField(
                controller: _location,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'Enter phone number'),
                validator: (value) {
                  if (value == null) return ("Enter company phone");
          
                  return null;
                },
                onChanged: (value) {
                },
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Website (optional) ', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    const TextSpan(
                      text: '',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              TextFormField(
                controller: _location,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                    ),
                    hintText: 'Enter phone number'),
                validator: (value) {
                  if (value == null) return ("Enter company phone");
          
                  return null;
                },
                onChanged: (value) {
                },
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Logo Image (optional)', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    const TextSpan(
                      text: '',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              Gap(8),
              LogoUploadWidget(),
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
