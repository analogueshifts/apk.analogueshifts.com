import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/user_login.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  final Function toggleView;
  const LoginView({super.key, required this.toggleView});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  // bool _isValid = true;

  bool _isEmail = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // PhoneNumber _number = PhoneNumber(isoCode: 'NG');

  bool _isPasswordVisible = true;
  bool _isFormValid = false;

  // bool _isLoading = false;

  void setLoader() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (mounted) {
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
  void _setFormValidState() {
    setState(() {
      if (_formKey.currentState == null) return;
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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel read = context.read<UserViewModel>();
    return  AbsorbPointer(
      absorbing: read.authState.isGenerating,
      child: Scaffold(
        appBar: PaylonyAppBarTwo(title: "Login", centerTitle: false,backTap: (){
          if(widget.toggleView == null)return;
          widget.toggleView!(true);
        },),
         body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                TextSemiBold(
                  "Sign up with one of the following",
                  color: AppColors.grey,
                ),
                Gap(15),
                Row(
                  children: [
                    Expanded(
                      child: TouchableOpacity(
                        onTap: () => read.continueWithGoogle(context),
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: AppColors.primaryGrey2, width: 1)),
                            child:
                                Center(child: SvgPicture.asset(AppAsset.google))),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: AppColors.primaryGrey2, width: 1)),
                          child:
                              Center(child:  SvgPicture.asset(Theme.of(context).colorScheme.brightness == Brightness.light ? AppAsset.appleSvg : "assets/images/apple-white.svg"))),
                    ),
                  ],
                ),
                Gap(20),
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
                      hintText: 'Enter your email address'),
                  validator: (value) {
                    if (value == null) return ("Enter your email");
                    if (CustomValidator.validEmail(value.trim()) == false)
                      return ("Invalid email");
      
                    return null;
                  },
                  onChanged: (value) {
                    _setFormValidState();
                  },
                ),
                Gap(15),
                TextSemiBold(
                  "Password",
                  color: AppColors.background,
                  fontWeight: FontWeight.w700,
                ),
                Gap(6),
                TextFormField(
                    controller: _passwordController,
                    obscureText: _isPasswordVisible,
                    validator: (value) {
                      if (value == null) return "Input password";
                      if (value.length < 6)
                        return "Password must contain 6 characters ";
                      return null;
                    },
                    onChanged: (value) {
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
                              ? Icon(Icons.visibility_outlined, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : Color(0xff767676))
                              : Icon(Icons.visibility_off_outlined,
                                  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : Color(0xff767676))
                                  ),
                    )),
                Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TouchableOpacity(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ForgotPasswordView(email: _emailController.text)));
                        },
                        child: TextSemiBold(
                          "Forgot Password",
                          color: AppColors.primaryColor,
                          fontSize: 14,
                        )),
                  ],
                ),
                Gap(40),
                BusyButton(disabled: _isFormValid, title: "Login", isLoading: context.watch<UserViewModel>().authState.isGenerating == false ? false : true, textColor: Colors.white, height: 58, onTap:(){
                  // setLoader();
                  if(_formKey.currentState == null)return;
                  if(_formKey.currentState!.validate()){
                     FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
                    final user = LoginUser(email: _emailController.text.trim(), password: _passwordController.text.trim().toString());
                    context.read<UserViewModel>().loginUser(user, context);
                    // setLoader();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isLoading = false;

  void updateLoader(bool value){

    if(!mounted)return;

    setState(() {
      _isLoading = value;
    });
  }
}
