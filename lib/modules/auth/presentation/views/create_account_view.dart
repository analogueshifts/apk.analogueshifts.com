import 'dart:async';

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/device_info.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:analogue_shifts_mobile/core/utils/webview.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/registration_request_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CreateAccountView extends StatefulWidget {
  final Function? toggleView;
  const CreateAccountView({super.key, this.toggleView});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // bool _isValid = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DeviceInfo _deviceInfo = GetIt.instance<DeviceInfo>();



  bool _isPasswordVisible = true;
  bool _isFormValid = false;


  void setLoader(){
    setState(() {
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if(mounted){
          setState(() {
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeNavigation()),
                  (Route<dynamic> route) => true);
        }

      });
    });
  }

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
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    UserViewModel user = context.read<UserViewModel>();
    return AbsorbPointer(
      absorbing: user.authState.isGenerating,
      child: Scaffold(
        appBar: PaylonyAppBarTwo(title: "Sign Up", centerTitle: false, backTap: (){
          if(widget.toggleView == null)return;
          widget.toggleView!(false);
        },),
        body: Consumer<UserViewModel>(
          builder: (_, auth, __) {
           return  SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Gap(20),
                  // TextSemiBold("Sign up with one of the following", color: AppColors.grey,),
                  // const Gap(15),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const CustomWebView(authorizationUrl: "https://accounts.google.com/o/oauth2/auth?client_id=40068646233-353skg8bdn8nhuqsaq0o1ner51thqr0e.apps.googleusercontent.com&redirect_uri=https%3A%2F%2Fapi.analogueshifts.com%2Fauth%2Fgoogle%2Fcallback&scope=openid+profile+email&response_type=code")
                  //       ),
                  //     );
                  //      },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(vertical: 15),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           border: Border.all(color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.08) : const Color(0xffFFFFFF).withOpacity(0.4), width: 1)
                  //       ),
                  //       child: Center(child: SvgPicture.asset(AppAsset.google))),
                  // ),
                  const Gap(20),
                  TextSemiBold("First Name", color: AppColors.background,fontWeight: FontWeight.w700,),
                  const Gap(6),
                  TextFormField(
                    controller: _firstNameController,
                    validator: (value){
                      CustomValidator.isEmptyString(value!, "first name");
                      if(value.isEmpty){
                        return ("Input your first name");
                      }

                      return null;
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
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: 'First Name'
                    ),
                    onChanged: (value){
                      _setFormValidState();

                    },
                  ),
                  const Gap(15),
                  TextSemiBold("Last Name", color: AppColors.background,fontWeight: FontWeight.w700,),
                  const Gap(6),
                  TextFormField(
                    controller: _lastNameController,
                    validator: (value){
                      CustomValidator.isEmptyString(value!, "last name");
                      if(value.isEmpty){
                        return ("Input your last name");
                      }
          
                      return null;
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
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                      hintText: 'Last Name'
                    ),
                    onChanged: (value){
                      _setFormValidState();
          
                    },
                  ),
                  const Gap(15),
                  TextSemiBold("Email", color: AppColors.background,fontWeight: FontWeight.w700,),
                  const Gap(6),
                  TextFormField(
                    controller: _emailController,
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
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
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
                  const Gap(15),
                  TextSemiBold("Password", color: AppColors.background,fontWeight: FontWeight.w700,),
                  const Gap(6),
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
                         fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.06) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.25) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: "Enter your password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                             icon: !_isPasswordVisible
                              ? Icon(Icons.visibility_outlined, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : const Color(0xff767676))
                              : Icon(Icons.visibility_off_outlined,
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : const Color(0xff767676))
                                  ),
                      )
                  ),
                  const Gap(4),
                  TextSemiBold(_passwordController.text.length < 8 ? "Must be at least 8 characters" : "", color: AppColors.grey, fontSize: 12,),
                  const Gap(40),
                  BusyButton(disabled: _isFormValid, title: "Create Account", isLoading: auth.authState.isGenerating, textColor: Colors.white, height: 58,
                      onTap:() async {
                    if(_formKey.currentState == null)return;
                    if(_formKey.currentState!.validate()){
                      int deviceType = _deviceInfo.getDeviceType();
                      final firebaseToken = getIt<DBService>().getFirebaseToken();
                      logger.d(firebaseToken);
                       FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
                      auth.registerUser(RegisterRequest(firstName: _firstNameController.text.trim(), lastName: _lastNameController.text.trim(), email: _emailController.text.trim(), password: _passwordController.text.trim(), passwordConfirmation: _passwordController.text.trim(), deviceToken: firebaseToken.toString()), context);
                    }
          
                  }),
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextSemiBold("Already have an account?",color: AppColors.textPrimaryColor2,),
                      const Gap(5),
                      TouchableOpacity(
                        onTap: () {
                          if(widget.toggleView == null)return;
                           widget.toggleView!(false);
                        },
                        child: TextSemiBold("Login Now", fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.primaryColor,))
                    ],
                  ),Gap(10)
                ],
              ),
            ),
          );
          }
        ),
      ),
    );
  }
}

