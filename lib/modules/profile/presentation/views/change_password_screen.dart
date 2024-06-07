import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/forgetpaasswordcreate.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
 bool _isPasswordVisible2 = true;
 bool _isPasswordVisible3 = true;


  final _formKey = GlobalKey<FormState>();

  void _setFormValidState(){
    setState(() {
      if (_formKey.currentState == null)return;
      if (_formKey.currentState!.validate()) {
      }else{
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
    return Consumer<UserViewModel>(
       builder: (context, UserViewModel user, child) {
      return AbsorbPointer(
        absorbing: user.authState.isGenerating,
        child: Scaffold(
          // backgroundColor: AppColors.white,
          appBar: const PaylonyAppBarTwo(title: "Change Password"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  TextSemiBold("Current Password", color: AppColors.background,fontWeight: FontWeight.w700,),
                  const Gap(6),
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
                         fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: "Enter your current password",
                        // hintStyle: TextStyle(
                        //   color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        // ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                             icon: !_isPasswordVisible
                              ? Icon(Icons.visibility_outlined, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                              : Icon(Icons.visibility_off_outlined,
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                                  ),
                      )
                  ),
                  const Gap(20),
                  TextSemiBold("New Password", color: AppColors.background,fontWeight: FontWeight.w700,),
                  const Gap(6),
                  TextFormField(
                      controller: _newPassword,
                      obscureText: _isPasswordVisible2,
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
                         fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: "Enter your new password",
                     
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible2 = !_isPasswordVisible2;
                              });
                            },
                             icon: !_isPasswordVisible2
                              ? Icon(Icons.visibility_outlined, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                              : Icon(Icons.visibility_off_outlined,
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                                  ),
                      )
                  ),
                  const Gap(20),
                  TextSemiBold("Re-type Password", color: AppColors.background,fontWeight: FontWeight.w700,),
                  const Gap(6),
                  TextFormField(
                      controller: _confirmPassword,
                      obscureText: _isPasswordVisible3,
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
                        fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: "Confirm your password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible3 = !_isPasswordVisible3;
                              });
                            },
                              icon: !_isPasswordVisible3
                              ? Icon(Icons.visibility_outlined, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                              : Icon(Icons.visibility_off_outlined,
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                                  ),
                      )
                  ),
                  const Gap(35),
                  BusyButton(title: "Save", 
                  isLoading: user.authState.isGenerating,
                  onTap:(){
                    FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                            currentFocus.focusedChild?.unfocus();
                          }
                          if (_formKey.currentState!.validate()) {
                             user.updatePassword(CreateForgetNewPasswordEntity(email: user.authState.user?.email, password: _newPassword.text.trim(), passwordConfirmation: _confirmPassword.text.trim()), context);
                          }
                   
                  })
                ],
              ),
            ),
          ),
        ),
      );
       }
    );
  }
}