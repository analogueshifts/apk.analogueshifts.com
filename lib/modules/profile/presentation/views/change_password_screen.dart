import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
final TextEditingController _oldPassword = TextEditingController();
final TextEditingController _newPassword = TextEditingController();
final TextEditingController _confirmPassword = TextEditingController();

 bool _isPasswordVisible = true;
  bool _isFormValid = false;

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  // void setLoader(){
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() {
  //       if(mounted){
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         Navigator.of(context).pushAndRemoveUntil(
  //             MaterialPageRoute(builder: (context) => const HomeNavigation()),
  //                 (Route<dynamic> route) => true);
  //       }

  //     });
  //   });
  // }

  String? _errorText;
  void _setFormValidState(){
    setState(() {
      if (_formKey.currentState == null)return;
      if (_formKey.currentState!.validate()) {
       _isFormValid = false;
      }else{
        _isFormValid = true;
      }
    });
  }

@override
  void dispose() {
  _oldPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PaylonyAppBarTwo(title: "Change Password"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(15),
              TextSemiBold("Current Password", color: AppColors.background,fontWeight: FontWeight.w700,),
              Gap(6),
              TextFormField(
                  controller: _oldPassword,
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
              Gap(20),
              TextSemiBold("New Password", color: AppColors.background,fontWeight: FontWeight.w700,),
              Gap(6),
              TextFormField(
                  controller: _oldPassword,
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
              Gap(20),
              TextSemiBold("Re-type Password", color: AppColors.background,fontWeight: FontWeight.w700,),
              Gap(6),
              TextFormField(
                  controller: _oldPassword,
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
              Gap(30),
              BusyButton(title: "Save", onTap:(){})
            ],
          ),
        ),
      ),
    );
  }
}