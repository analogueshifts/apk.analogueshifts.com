
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CompaniesBottomSheet extends StatefulWidget {
  const CompaniesBottomSheet({super.key});

  @override
  State<CompaniesBottomSheet> createState() => _CompaniesBottomSheetState();
}

class _CompaniesBottomSheetState extends State<CompaniesBottomSheet> {
  @override
  Widget build(BuildContext context) {
      return Wrap(
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
                        color: Color(0xffE7E7E7),
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBold("Companies", fontSize: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                          child: SvgPicture.asset("assets/icons/close-icon.svg"))
                    ],
                  ),
                  Gap(30),
                  TextSemiBold("Analogue Shifts", fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xff7B7B7B),),
                  Gap(15),
                  TextSemiBold("Pay Shifts", fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xff7B7B7B),),
                  Gap(15),
                  TextSemiBold("Host Shifts", fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xff7B7B7B),),
                  Gap(15),
                  Gap(10),

                ],
              ),
            ),
          )
        ],
      );
  }
}