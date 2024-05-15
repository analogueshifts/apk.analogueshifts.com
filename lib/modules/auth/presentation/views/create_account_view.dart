

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/loading_dailog.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // bool _isValid = true;

  bool _isEmail = true;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final DeviceInfo _deviceInfo = GetIt.instance<DeviceInfo>();

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
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeNavigation()),
                  (Route<dynamic> route) => true);
        }

      });
    });
  }

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
    _emailController.dispose();
    _nameController.dispose();
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  TextSemiBold("Sign up with one of the following", color: AppColors.grey,),
                  Gap(15),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomWebView(authorizationUrl: "https://thepoolapp.site/api/v1/auth/register/google")
                        ),
                      );
                       },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.primaryGrey2, width: 1)
                        ),
                        child: Center(child: SvgPicture.asset(AppAsset.google))),
                  ),
                  Gap(20),
                  TextSemiBold("Name", color: AppColors.background,fontWeight: FontWeight.w700,),
                  Gap(6),
                  TextFormField(
                    controller: _nameController,
                    validator: (value){
                      CustomValidator.isEmptyString(value!, "name");
                      if(value.isEmpty){
                        return ("Input your name");
                      }
          
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                       fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
                        ),
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
                       fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.4)
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
                         fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.4) : Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
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
                             icon: !_isPasswordVisible
                              ? Icon(Icons.visibility_outlined, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                              : Icon(Icons.visibility_off_outlined,
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white)
                                  ),
                      )
                  ),
                  Gap(4),
                  TextSemiBold(_passwordController.text.length < 8 ? "Must be at least 8 characters" : "", color: AppColors.grey, fontSize: 12,),
                  Gap(40),
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
                      auth.registerUser(RegisterRequest(name: _nameController.text.trim(), email: _emailController.text.trim(), password: _passwordController.text.trim(), passwordConfirmation: _passwordController.text.trim(), deviceToken: firebaseToken.toString() ?? "", deviceType: deviceType.toString()), context);
                    }
          
                  }),
                  Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextSemiBold("Already have an account?",color: AppColors.textPrimaryColor2,),
                      Gap(5),
                      TouchableOpacity(
                        onTap: () {
                          if(widget.toggleView == null)return;
                           widget.toggleView!(false);
                        },
                        child: TextSemiBold("Login Now", fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.primaryColor,))
                    ],
                  )
          
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

