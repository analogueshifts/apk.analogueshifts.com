import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NoItemVetting extends StatelessWidget {
  const NoItemVetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/no_vetting.png", width: 150.w, height: 150.h,),
            const Gap(15),
            const Text("Empty Forms", style: TextStyle(fontSize: 18),),
            const Gap(15),
            const Text("Click on the button at the bottom to create a new form", textAlign: TextAlign.center, style: TextStyle(
              color: Color(0xff909090)
            ),),
            const Gap(25),
            // BusyButton(title: "Create Form", onTap:() {
            //   // AppSnackbar.error(context, message: "Vetting Service is down, try later");
            //    Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const CreateVettingScreen()),
            //   );
              
            // },)
          ],
        ),
      ),
    );
  }
}