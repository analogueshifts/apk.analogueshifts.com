import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/change_password.screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class UserVerificationOtpScreen extends StatefulWidget {
  final String? email;
  const UserVerificationOtpScreen({super.key, this.email});

  @override
  State<UserVerificationOtpScreen> createState() => _UserVerificationOtpScreenState();
}

class _UserVerificationOtpScreenState extends State<UserVerificationOtpScreen> {
  bool _isOtpCompleted = false;

  void _setOtpState(bool value){
    if(mounted){
      setState(() {
        _isOtpCompleted = value;
      });
    }
  }
  String? _otp;

  @override
  void initState() {  
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().initateUserVerification(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaylonyAppBarTwo(
        title: "OTP Verification",
        centerTitle: false,
      ),
      body: Consumer<UserViewModel>(
        builder: (_, auth, __) {
        return AbsorbPointer(
          absorbing: auth.authState.isGenerating,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(
                      20,
                    ),
                    const Gap(5),
                    TextSemiBold(
                        'Enter the verification code we just sent on your email address.'),
                    const Gap(30),
                    OTPTextField(
                      length: 5,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 60,
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Color(0xff000000).withOpacity(0.02),
                        borderColor: AppColors.primaryColor,
          
                      ),
                      style: TextStyle(
                        fontSize: 17
                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onCompleted: (pin) {
                        _otp = pin;
                        _setOtpState(true);
                      },
                    ),
                    const Gap(60),
                    BusyButton(
                        title: "Verify Code",
                        textColor: Colors.white,
                        isLoading: auth.authState.isGenerating,
                        // disabled: _isOtpCompleted == true ? false : true,
                        height: 58,
                        onTap: () {
                          // if(_isOtpCompleted){
                          //   if(widget.email == null && _otp == null)return;
                          //    auth.verifyPasswordOtp(VerifyPasswordEntity(otp: _otp?.trim(), email: widget.email), context);
                          // }
           
                        }
                        ),
                   Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextSemiBold("Didn’t received code?",color: AppColors.textPrimaryColor2,),
                    Gap(5),
                    TouchableOpacity(
                      onTap: () {
                        auth.initateUserVerification(context);
                      },
                      child: TextSemiBold("Resend", fontWeight: FontWeight.w800, color: AppColors.background,))
                  ],
                )
              ],
            ),
          ),
        );
        }
      ),
    );
  }
}