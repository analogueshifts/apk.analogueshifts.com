import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/verify_password.entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/change_password.screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class VerifyUserOtpScreen extends StatefulWidget {
  final String? email;
  const VerifyUserOtpScreen({super.key, this.email});

  @override
  State<VerifyUserOtpScreen> createState() => _VerifyUserOtpScreenState();
}

class _VerifyUserOtpScreenState extends State<VerifyUserOtpScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaylonyAppBarTwo(
        title: "",
        centerTitle: false,
      ),
      body: Consumer<UserViewModel>(
        builder: (_, auth, __) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(
                    20,
                  ),
                  TextBold(
                    'OTP Verification',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
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
                      enabledBorderColor: AppColors.primaryColor
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
                        if(_isOtpCompleted){
                          if(widget.email == null && _otp == null)return;
                           FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                            currentFocus.focusedChild?.unfocus();
                          }
                           auth.verifyPasswordOtp(VerifyPasswordEntity(otp: _otp?.trim(), email: widget.email), context);
                        }
         
                      }),
            ],
          ),
        );
        }
      ),
    );
  }
}