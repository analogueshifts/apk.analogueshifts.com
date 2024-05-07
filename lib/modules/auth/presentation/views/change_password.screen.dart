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

class ResetChangePasswordScreen extends StatefulWidget {
  final String? email;
  const ResetChangePasswordScreen({super.key, this.email});

  @override
  State<ResetChangePasswordScreen> createState() => _ResetChangePasswordScreenState();
}

class _ResetChangePasswordScreenState extends State<ResetChangePasswordScreen> {
final TextEditingController _newPassword = TextEditingController();
final TextEditingController _confirmPassword = TextEditingController();

 bool _isPasswordVisible = true;
 bool _isPasswordVisible2 = true;
  bool _isFormValid = false;

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

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
  _newPassword.dispose();
  _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.brightness;
    return Consumer<UserViewModel>(
      builder: (_, auth, __) {
      return Scaffold(
        // backgroundColor: AppColors.white,
        appBar: const PaylonyAppBarTwo(title: ""),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(15),
                TextSemiBold("Create New Password", color: theme == Brightness.light ? AppColors.background : AppColors.white,fontWeight: FontWeight.w700, fontSize: 20,),
                 TextSemiBold(
                      'Your new password must be unique from those previously used.', color: theme == Brightness.light ? AppColors.background : AppColors.white, fontSize: 14,),
                Gap(15),
                TextFormField(
                    controller: _newPassword,
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
                      fillColor: theme == Brightness.light ? AppColors.white : AppColors.background,
                       focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        ),
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
                TextSemiBold("Re-type Password", color: theme == Brightness.light ? AppColors.background : AppColors.white,fontWeight: FontWeight.w700,),
                Gap(6),
                TextFormField(
                    controller: _confirmPassword,
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
                      fillColor: theme == Brightness.light ? AppColors.white : AppColors.background,
                       focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                      hintText: "Enter your password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible2 = !_isPasswordVisible2;
                            });
                          },
                          icon: !_isPasswordVisible ? Icon(Icons.visibility_outlined, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white) : Icon(
                              Icons.visibility_off_outlined,
                              color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white
                          )
                      ),
                    )
                ),
                Gap(30),
                BusyButton(title: "Save", isLoading: auth.authState.isGenerating, onTap:(){
                  auth.updatePassword(CreateForgetNewPasswordEntity(email: widget.email, password: _newPassword.text.trim(), passwordConfirmation:_confirmPassword.text.trim()), context);
                })
              ],
            ),
          ),
        ),
      );
      }
    );
  }
}