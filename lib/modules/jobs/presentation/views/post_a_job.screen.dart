
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/step.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/application_deadline_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/companies_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/countries_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/currency_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/employment_type_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/job_field_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/job_roles.bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/paymentType_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/qualification_bottom_sheet.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/widgets/text_editor.dart';
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
  final _currency = TextEditingController();
  final _paymentType = TextEditingController();
  final _maxAmount = TextEditingController();
  final _minAMount = TextEditingController();
  final _employmentType = TextEditingController();
  final _applicationDeadline = TextEditingController();
  final _city = TextEditingController();
  final _description = TextEditingController();
  final _applyOption = TextEditingController();
  int _currentPage = 1;
  bool isFirstFormValid = false;
  bool isSecondFormValid = false;

  String? _jobDescription;





  validateFirstForm(){
    if(_companyName.text.isEmpty || _location.text.isEmpty || _jobField.text.isEmpty || _qualifiication.text.isEmpty || _location.text.isEmpty || _city.text.isEmpty || _employmentType.text.isEmpty){
      setState(() {
        isFirstFormValid = false;
      });
    }else{
      setState(() {
        isFirstFormValid = true;
      });

    }
  }

  validateSecondForm(){
    if(_applicationDeadline.text.isEmpty || _paymentType.text.isEmpty || _maxAmount.text.isEmpty || _minAMount.text.isEmpty || _currency.text.isEmpty){
      setState(() {
        isSecondFormValid = false;
      });
    }else{
      setState(() {
        isSecondFormValid = true;
      });

    }
  }
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
                    validateFirstForm();
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
                   validateFirstForm();
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
                    validateFirstForm();
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
                   validateFirstForm();
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
                onTap: () async{;
                 final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:(context) {
                        return CountriesBottomSheet();
                      }
                  );
                 if(result != null && result.runtimeType.toString().toLowerCase() == "string"){
                   setState(() {
                     _location.text = result!;
                   });
                   validateFirstForm();
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
                      TextSemiBold(_location.text == null ? "Choose Country" : _location.text, color: isLight ? Color(0xff000000).withOpacity(_location.text.isEmpty ? 0.40 : 0.90) : AppColors.grey,),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'City/Town', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              TextFormField(
                controller: _city,
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
                    hintText: 'Input city'),
                validator: (value) {
                  if (value == null) return ("Enter city");

                  return null;
                },
                onChanged: (value) {
                  validateFirstForm();
                },
              ),
              Gap(20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Employment Type', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const Gap(6),
              InkWell(
                onTap: () async{;
                final results = await showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    builder:(context) {
                      return EmploymentTypeBottomSheet();
                    }
                );


                if(results != null){
                  setState(() {
                    _employmentType.text = results;
                  });
                  validateFirstForm();

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
                      TextSemiBold(_employmentType.text == null ? "Select employment type" : _employmentType.text, color: isLight ? Color(0xff000000).withOpacity(_employmentType.text.isEmpty ? 0.40 : 0.90) : AppColors.grey),
                      Icon(Icons.keyboard_arrow_down)

                    ],
                  ),
                ),
              ),
              Gap(20),
              BusyButton(
                  title: "Next",
                  disabled: isFirstFormValid == true ? false : true,
                  onTap:(){
                validateFirstForm();
                if(isFirstFormValid){
                  setState(() {
                    _currentPage = 2;
                });
                }
              }),
              Gap(30)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep2(){
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
                  StepIndicator(currentStep: 2, totalSteps: 3),

                  Gap(30),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Payment Type', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
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
                            return PaymentTypeBottomSheet();

                          }
                      );

                      if(results != null){
                        setState(() {
                          _paymentType.text = results;
                        });
                        validateSecondForm();
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
                          TextSemiBold(_paymentType.text.isEmpty ? "Select the preferred payment type" : _paymentType.text,color:isLight ? Color(0xff000000).withOpacity(_paymentType.text.isEmpty ? 0.40 : 0.9) : AppColors.grey,),
                          Icon(Icons.keyboard_arrow_down)

                        ],
                      ),
                    ),
                  ),
                  Gap(15),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Currency', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
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
                            return CurrencyBottomSheet();
                          }
                      );

                      if(results != null){
                        setState(() {
                          _currency.text = results;
                        });
                        validateSecondForm();
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
                          TextSemiBold(_currency.text.isEmpty ? "Select Currency " : _currency.text, color: isLight ? Color(0xff000000).withOpacity(_currency.text.isEmpty ? 0.40 : 0.90) : AppColors.grey),
                          Icon(Icons.keyboard_arrow_down)

                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Minimum Amount', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  TextFormField(
                    controller: _minAMount,
                    keyboardType: TextInputType.number,
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
                        hintText: 'Input minimum amount'),
                    validator: (value) {
                      if (value == null) return ("Enter min amount");

                      return null;
                    },
                    onChanged: (value) {
                      validateSecondForm();
                    },
                  ),
                  Gap(20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Maximum Amount', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  TextFormField(
                    controller: _maxAmount,
                    keyboardType: TextInputType.number,

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
                        hintText: 'Input max amount'),
                    validator: (value) {
                      if (value == null) return ("Enter amount");

                      return null;
                    },
                    onChanged: (value) {
                      validateSecondForm();
                    },
                  ),
                  Gap(20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'OR Select Quickly', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  InkWell(
                    onTap: () async{;
                    final results = await showModalBottomSheet(
                        context: context,
                        // isScrollControlled: true,
                        builder:(context) {
                          return ApplicationBottomSheet();
                        }
                    );


                    if(results != null){
                      setState(() {
                        _applicationDeadline.text = results;
                        // _applicationDeadline.text = results;
                      });validateSecondForm();

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
                          TextSemiBold(_applicationDeadline.text == null ? "Select  deadline" : _applicationDeadline.text, color: isLight ? Color(0xff000000).withOpacity(_applicationDeadline.text.isEmpty ? 0.40 : 0.90) : AppColors.grey),
                          Icon(Icons.keyboard_arrow_down)

                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  BusyButton(
                      title: "Next",
                      disabled: isSecondFormValid == true ? false : true,
                      onTap:(){
                        validateFirstForm();
                        if(isSecondFormValid){
                          setState(() {
                            _currentPage = 3;
                          });
                        }
                      }),
                  Gap(30)
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildStep3(){
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
                  StepIndicator(currentStep: 3, totalSteps: 3),

                  Gap(30),

                  Gap(20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Tell us about the role (Description):', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                        TextSpan(
                          text: '',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  TextEditor(html: _jobDescription,),

                  Gap(20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'How to apply', style: TextStyle(fontWeight: FontWeight.w700,color: isLight ? AppColors.background : AppColors.white,),),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  InkWell(
                    onTap: () async{;
                    final results = await showModalBottomSheet(
                        context: context,
                        // isScrollControlled: true,
                        builder:(context) {
                          return ApplicationBottomSheet();
                        }
                    );


                    if(results != null){
                      setState(() {
                        //TODO: MAkE SURE YIU ADD STATE MANAMGEMENT TO THIS.
                        _applyOption.text = results;
                        // _applicationDeadline.text = results;
                      });
                      validateFirstForm();

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
                          TextSemiBold(_applyOption.text == null ? "Select how to apply option" : _applyOption.text, color: isLight ? Color(0xff000000).withOpacity(_applyOption.text.isEmpty ? 0.40 : 0.90) : AppColors.grey),
                          Icon(Icons.keyboard_arrow_down)

                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  BusyButton(
                      title: "Next",
                      // disabled: isFirstFormValid == true ? false : true,
                      onTap:(){
                        logger.d(_jobDescription);
                        // validateFirstForm();
                        // if(isFirstFormValid){
                        //   setState(() {
                        //     _currentPage = 3;
                        //   });
                        // }
                      }),
                  Gap(30)
                ],
              ),
            ),
          ),
    );
  }
  }

