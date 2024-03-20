

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CreateAccountView extends StatefulWidget {
  final Function? toggleView;
  const CreateAccountView({super.key, this.toggleView});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // bool _isValid = true;

  bool _isEmail = true;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  // PhoneNumber _number = PhoneNumber(isoCode: 'NG');

  bool _isPasswordVisible = true;
  bool _isFormValid = false;

  bool _isLoading = false;

  void setLoader(){
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if(mounted){
          setState(() {
            _isLoading = false;
          });
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => const HomeNavigation()),
          //         (Route<dynamic> route) => true);
        }

      });
    });
  }

  String? _errorText;
  void _setFormValidState(){
    setState(() {
      if (_formKey.currentState == null)return;
      if (_formKey.currentState!.validate()) {
        if (_isEmail == false) {
          if (_nameController.text.isNotEmpty) {
            _isFormValid = false;
          }else{
            _isFormValid = true;

          }

        }else{
          _isFormValid = false;
        }
      }else{
        _isFormValid = true;
      }
    });
  }
@override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaylonyAppBarTwo(title: "Sign Up", centerTitle: false,),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              TextSemiBold("Sign up with one of the following", color: AppColors.grey,),
              Gap(15),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.primaryGrey2, width: 1)
                  ),
                  child: Center(child: SvgPicture.asset(AppAsset.google))),
              Gap(20),
              TextSemiBold("Name", color: AppColors.background,fontWeight: FontWeight.w700,),
              Gap(6),
              TextFormField(
                controller: _nameController,
                validator: (value){
                  CustomValidator.isEmptyString(value!, "name");

                  return null;
                },
                decoration: textInputDecoration.copyWith(
                  hintText: 'Full Name'
                ),
                onChanged: (value){
                  _setFormValidState();

                },
              ),
              Gap(15),
              TextSemiBold("Email", color: AppColors.background,fontWeight: FontWeight.w700,),
              Gap(6),
              TextFormField(
                controller: _emailController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter your email address'
                ),

                validator: (value){
                  if(value == null)return ("Enter your email");
                  if(CustomValidator.validEmail(value.trim()) == false)return ("Invalid email");

                  return null;
                },
                onChanged: (value){
                  _setFormValidState();

                },
              ),
              Gap(15),
              TextSemiBold("Password", color: AppColors.background,fontWeight: FontWeight.w700,),
              Gap(6),
              TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordVisible,
                  validator: (value){
                    if(value == null)return "Input password";
                    if(value.length < 6)return "Password must contain 6 characters ";
                    return null;
                  },
                  onChanged: (value){
                    _setFormValidState();

                  },
                  obscuringCharacter: '*',
                  decoration: textInputDecoration.copyWith(
                    // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    fillColor: AppColors.white,
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: !_isPasswordVisible ? const Icon(Icons.visibility_outlined) : const Icon(
                            Icons.visibility_off_outlined,
                            color: AppColors.background
                        )
                    ),
                  )
              ),
              Gap(4),
              TextSemiBold(_passwordController.text.length < 8 ? "Must be at least 8 characters" : "", color: AppColors.grey, fontSize: 12,),
              Gap(40),
              BusyButton(title: "Create Account", isLoading: _isLoading, textColor: Colors.white, height: 58, onTap:(){
                setLoader();
              }),
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextSemiBold("Already have an account?",color: AppColors.textPrimaryColor2,),
                  Gap(5),
                  TextSemiBold("Login Now", fontWeight: FontWeight.w800, color: AppColors.background,)
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
