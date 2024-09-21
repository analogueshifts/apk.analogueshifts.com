
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/user_verification.view.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PromptVerifyBottomSheet extends StatefulWidget {
  const PromptVerifyBottomSheet({super.key});

  @override
  State<PromptVerifyBottomSheet> createState() => _PromptVerifyBottomSheetState();
}

class _PromptVerifyBottomSheetState extends State<PromptVerifyBottomSheet> {

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Consumer<UserViewModel>(
      builder: (_, auth, __) =>
          Wrap(
            children: [
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 70.w,
                          height: 5.h,
                          margin: EdgeInsets.only(top: 3),
                          decoration: BoxDecoration(
                              color: isLight ? Color(0xffE7E7E7) : AppColors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSemiBold("Verify Your Account", fontSize: 20,),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset("assets/icons/close-icon.svg"))
                        ],
                      ),
                      Gap(30),
                      TextSemiBold("Access more features when you verify your account.", fontSize: 16, color: Color(0xff6D6D6D), overflow: TextOverflow.ellipsis,),
                      Gap(60),

                      BusyButton(title: "Verify Now", onTap: (){
                        if(context.mounted && auth.authState.user?.user?.email != null){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => UserVerificationOtpScreen(email: auth.authState.user?.user?.email)));
                        }
                      }),


                      Gap(15),

                    ],
                  ),
                ),
              )
            ],
          ),
    );
  }
}
