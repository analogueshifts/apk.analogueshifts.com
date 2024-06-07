import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/widgets/text_editor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateVettingScreen extends StatefulWidget {
  const CreateVettingScreen({super.key});

  @override
  State<CreateVettingScreen> createState() => _CreateVettingScreenState();
}

class _CreateVettingScreenState extends State<CreateVettingScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TextBold(
              'Vetting System',
              fontSize: 20,
              color: AppColors.textPrimaryColor,
              fontWeight: FontWeight.w700,
            ),

            elevation: 0.0,
            centerTitle: false,
            bottom: const TabBar(
                // isScrollable: true,
                // tabAlignment: TabAlignment.start,
                indicatorPadding: EdgeInsets.zero,
                labelColor: AppColors.primaryGreen,
                dividerHeight: 0,
                indicatorColor: Colors.transparent,
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryGreen,
                ),
                padding: EdgeInsets.zero,
                tabs: [
                  Text('General'),
                  Text('Subscriptions'),
                ]),
            // foregroundColor: AppColors.white,
          ),
          body: TabBarView(children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
               
               child: Column(
                children: [
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: screenWidth(context) * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextSemiBold("Add Question",color: AppColors.primaryColor,),
                            const Icon(Icons.add, color: AppColors.primaryColor,)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      TextEditor(),
                      
                    ],
                  )
                ],
               ),
             ),
            const Placeholder()
          ])),
    );
  }
}