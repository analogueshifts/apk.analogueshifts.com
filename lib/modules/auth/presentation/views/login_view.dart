import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/core/utils/validator.dart';
import 'package:analogue_shifts_mobile/core/utils/webview.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_user.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // PhoneNumber _number = PhoneNumber(isoCode: 'NG');

  bool _isPasswordVisible = true;
  bool _isFormValid = false;

  bool siginIn = false;

  // bool _isLoading = false;

  void setLoader() {
    setState(() {
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (mounted) {
          setState(() {
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeNavigation()),
                  (Route<dynamic> route) => true);
        }
      });
    });
  }

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
    final theme = Theme.of(context).colorScheme;
    UserViewModel read = context.read<UserViewModel>();
    return  AbsorbPointer(
      absorbing: read.authState.isGenerating,
      child: Scaffold(
         body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight(context) * 0.27,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/login-bg.png"), fit: BoxFit.cover)
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(child: Image.asset("assets/images/white-logo.png", width: 95, height: 76,)),
                          Positioned(
                              child: Image.asset("assets/icons/back-button.white.png", width: 30, height: 30,),
                          ),


                        ],
                      ),
                    ),
                  )

                  // child: SvgPicture.asset("assets/icons/back-arrow-white.svg", width: 30, height: 50,),
                ),
                Gap(35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSemiBold(
                        "Login with one of the following",
                        color: AppColors.grey,
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: TouchableOpacity(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CustomWebView(authorizationUrl: "https://accounts.google.com/o/oauth2/auth?client_id=40068646233-353skg8bdn8nhuqsaq0o1ner51thqr0e.apps.googleusercontent.com&redirect_uri=https%3A%2F%2Fapi.analogueshifts.com%2Fauth%2Fgoogle%2Fcallback&scope=openid+profile+email&response_type=code")
                                  ),
                                );

                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Theme.of(context).colorScheme.brightness == Brightness.dark ? const Color(0xffFFFFFF).withOpacity(0.6) : AppColors.primaryGrey2 , width: 1)),
                                  child:
                                  Center(child: SvgPicture.asset(AppAsset.google))),
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      TextSemiBold(
                        "Email",
                        color: theme.brightness == Brightness.light ? AppColors.background : AppColors.white,
                        fontWeight: FontWeight.w700,),
                      const Gap(6),
                      TextFormField(
                        controller: _emailController,
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
                            hintText: 'Enter your email address'),
                        validator: (value) {
                          if (value == null) return ("Enter your email");
                          if (CustomValidator.validEmail(value.trim()) == false) {
                            return ("Invalid email");
                          }

                          return null;
                        },
                        onChanged: (value) {
                          _setFormValidState();
                        },
                      ),
                      const Gap(15),
                      TextSemiBold(
                        "Password",
                        color: theme.brightness == Brightness.light ? AppColors.background : AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      const Gap(6),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          validator: (value) {
                            if (value == null) return "Input password";
                            if (value.length < 6) {
                              return "Password must contain 6 characters ";
                            }
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
                                    color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.07) : const Color(0xffFFFFFF).withOpacity(0.18)
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.7) : const Color(0xffFFFFFF).withOpacity(0.18)
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
                          )),
                      const Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SizedBox(
                          //   width: 15.w,
                          //   height: 15.w,
                          //   child: Checkbox(
                          //     value: siginIn,
                          //     onChanged: (value) {
                          //       if (mounted) {
                          //         setState(() {
                          //           siginIn = !siginIn;
                          //         });
                          //       }
                          //     },
                          //     checkColor: AppColors.white,
                          //     activeColor: AppColors.primaryColor,
                          //     focusColor: AppColors.primaryColor,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(2.0),
                          //     ),
                          //     side: MaterialStateBorderSide.resolveWith(
                          //           (states) => const BorderSide(width: 1.0, color: AppColors.primaryGrey),
                          //     ),
                          //   ),
                          // ),
                          TouchableOpacity(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ForgotPasswordView(email: _emailController.text)));
                          },
                          child: TextSemiBold(
                            "Forgot Password?",
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          )),
                      ]
                      ),
                      const Gap(40),
                      BusyButton(
                          disabled: _isFormValid,
                          title: "Login",
                          isLoading: context.watch<UserViewModel>().authState.isGenerating == false ? false : true,
                          textColor: Colors.white, height: 58, onTap:(){
                        // setLoader();
                        if(_formKey.currentState == null)return;
                        if(_formKey.currentState!.validate()){
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                            currentFocus.focusedChild?.unfocus();
                          }
                          final user = LoginUser(email: _emailController.text.trim().toLowerCase(), password: _passwordController.text.trim().toString());
                          context.read<UserViewModel>().loginUser(user, context);
                          // setLoader();
                        }
                      }),
                      Gap(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextSemiBold("Don’t already have an account?",  color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
                          Gap(5),
                          InkWell(
                            onTap: (){
                              widget.toggleView(false);
                            },
                              child: TextSemiBold("Sign up", color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,fontWeight: FontWeight.w700,))
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }


  void updateLoader(bool value){

    if(!mounted)return;

    setState(() {
    });
  }
}
