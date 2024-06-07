import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DeactivateAccountScreen extends StatefulWidget {
  const DeactivateAccountScreen({super.key});

  @override
  State<DeactivateAccountScreen> createState() => _DeactivateAccountScreenState();
}

class _DeactivateAccountScreenState extends State<DeactivateAccountScreen> {

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

   final _formKey = GlobalKey<FormState>();

  // PhoneNumber _number = PhoneNumber(isoCode: 'NG');

  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, UserViewModel user, child) {
      return AbsorbPointer(
        absorbing: user.authState.isGenerating,
        child: Scaffold(
          appBar: const PaylonyAppBarTwo(title: "Deactivate Account"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    user.authState.user?.profile == null  ? const Center(child: Icon(Icons.verified_user)) : Center(
                      child: CircleAvatar(
                          radius: 30.w,
                          child: Center(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: user.authState.user?.profile ?? "",
                                width: 60.w,
                                height: 60.h,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.background,
                                  minRadius: 50,
                                  child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error, size: 50,),
                              ),
                            ),
                          ),
                        ),
                    ),
                    const Gap(5),
                    Center(
                      child: Text(
                        Functions.capitalize(user.authState.user?.name.toString() ?? "", ),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Gap(25),
                    Text(
                      'Temporarily  Deactivate your account instead of completely deleting it',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    const Gap(18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: Text(
                          'Your Profile would be temporarily hidden until you activate it again by logging back in.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 13,
                            color: const Color(0xff909090)
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextSemiBold(
                      "Enter your Password",
                      color: AppColors.background,
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
                        obscuringCharacter: '*',
                        decoration: textInputDecoration.copyWith(
                           fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffE5E5E5) : const Color(0xffFFFFFF).withOpacity(0.18)
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffE5E5E5): const Color(0xffFFFFFF).withOpacity(0.18)
                              )
                            ),
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffE5E5E5) : const Color(0xffFFFFFF).withOpacity(0.4)
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
                    const Gap(24),
                    TextSemiBold(
                      "Please what’s your reason?",
                      color: AppColors.background,
                      fontWeight: FontWeight.w700,
                    ),
                    const Gap(6),
                    TextFormField(
                        controller: _reasonController,
                        validator: (value) {
                          if (value == null) return "Input a reason";
                          if (value.isEmpty) return "Input a reason";
                          return null;
                        },
                       
                        decoration: textInputDecoration.copyWith(
                           fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.2) : const Color(0xffFFFFFF).withOpacity(0.18)
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.2) : const Color(0xffFFFFFF).withOpacity(0.18)
                              )
                            ),
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.2) : const Color(0xffFFFFFF).withOpacity(0.4)
                            ),
                          hintText: "Input reason here",
                        
                        )
                        ),
                    const Gap(24),
                    BusyButton(title: "Deactivate Account", onTap:() {
                      if (_formKey.currentState!.validate()) {
                         showDialog( barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : const Color(0xff110C00).withOpacity(0.8),context: context, builder:(context) {
                      return deactivateDialog(context);
                    },);
                      }
                    
                      
                    },),
                    const Gap(20),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog( barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : const Color(0xff110C00).withOpacity(0.8),context: context, builder:(context) {
                              return deleteDialog(context);
                            },);
                        }
                        
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Text("Delete Account",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff6D6D6D) : AppColors.white
                        ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ),
          ),
        ),
      );
      }
    );
  }

  Widget deactivateDialog(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Consumer<UserViewModel>(
        builder: (context, auth, child) {
          return Container(
            
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                           SvgPicture.asset(AppAsset.logout),
                          const Gap(35),
                          const Text(
                            'Deactivate Account',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Gap(18),
                          
                          const Text(
                            'Your Profile would be temporarily hidden until you activate it again by logging back in.',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              color: Color(0xff6D6D6D),
                              // fontFamily: AppFonts.mulishRegular,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              // color: AppColors.textColor,
                            ),
                          ),
                          const Gap(16),
                        ],
                      ),
                      
                      const Gap(24),
                      Column(
                        children: [
                         
                       
                          TouchableOpacity(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.primaryColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "No, Cancel",
                                  style: TextStyle(
                                      // fontFamily: AppFonts.mulishRegular,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                           const Gap(16),
                          TouchableOpacity(
                            onTap: () {
                               FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
                              auth.deleteorDisableUser(context, false, _passwordController.text.trim(), _reasonController.text.trim());
                              // Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryColor
                                    ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: auth.authState.isGenerating ? SizedBox(height: 15.h, width: 20.w, child: const CircularProgressIndicator(color: AppColors.primaryColor,)) :  const Text(
                                  "Yes, deactivate my account",
                                  style: TextStyle(
                                    fontFamily: AppFonts.manRope,
                                    color: AppColors.primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget deleteDialog(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Consumer<UserViewModel>(
        builder: (context, auth, child) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                           Image.asset("assets/images/warninng.png", width: 50.w,),
                          const Gap(25),
                          const Text(
                            'Delete  your account?',
                            style: TextStyle(
                              // fontFamily: AppFonts.mulishRegular,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              // color: AppColors.black,
                            ),
                          ),
                          const Gap(18),
                          
                          const Text(
                            'You will lose all your data by deleting your account. This action cannot be undone ',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              color: Color(0xff6D6D6D),
                              // fontFamily: AppFonts.mulishRegular,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              // color: AppColors.textColor,
                            ),
                          ),
                          const Gap(16),
                        ],
                      ),
                      
                      const Gap(24),
                      Column(
                        children: [
                         
                       
                          TouchableOpacity(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xffFF0000)
                              ),
                              child: const Center(
                                child: Text(
                                  "No, Cancel",
                                  style: TextStyle(
                                      // fontFamily: AppFonts.mulishRegular,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                           const Gap(20),
                          TouchableOpacity(
                            onTap: () {
                               FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
                              auth.deleteorDisableUser(context, true, _passwordController.text.trim(), _reasonController.text.trim());
                              // Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffFF0000)
                                    // width: 1, color: AppColors.secondary,
                                    ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: auth.authState.isGenerating ? SizedBox(height: 15.h, width: 20.w, child: const CircularProgressIndicator(color: Color(0xffFF0000),)) : const Text(
                                  "Yes, deactivate my account",
                                  style: TextStyle(
                                    fontFamily: AppFonts.manRope,
                                    color: Color(0xffFF0000),
                                      // fontFamily: AppFonts.mulishRegular,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      // color: AppColors.secondary
                                      ),
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}