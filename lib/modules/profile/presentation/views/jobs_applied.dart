import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/custom_single_chile_scroll_view.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/home/data/model/job_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobsAppliedScreen extends StatefulWidget {
  const JobsAppliedScreen({super.key});

  @override
  State<JobsAppliedScreen> createState() => _JobsAppliedScreenState();
}

class _JobsAppliedScreenState extends State<JobsAppliedScreen> {
    final List<RecentJob> _recentJob = [
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/moniepoint.png", title: "Software Engineer", description: "Moniepoint"),
    RecentJob(image: "assets/images/work-hotshift.png", title: "Data Analyst", description: "Hostshifts"),
   RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/moniepoint.png", title: "Software Engineer", description: "Moniepoint"),
    RecentJob(image: "assets/images/work-hotshift.png", title: "Data Analyst", description: "Hostshifts"),
  ];


  final TextEditingController _search = TextEditingController();

   bool _isLoading = false;

  void setSearchLoader(){
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if(mounted){
          setState(() {
            _isLoading = false;
            _search.clear();
          });
        }

      });
    });
  }

   @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaylonyAppBarTwo(title: "Jobs Applied",  actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                Positioned(
                  right: 4,
                  top: 2,
                  child: Container(
                    alignment: Alignment.topRight,
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(18)
                    ),
                  ),
                ),
                const Icon(Icons.notifications_none_outlined
              )
              ]
              
              )
          )
        ],),
      body: CustomSingleChildScrollView(child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _search,
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: _isLoading ? Container(margin: EdgeInsets.only(left:
                          5), height: screenHeight(context) * 0.01, width: screenWidth(context) * 0.01, child: CircularProgressIndicator(color: AppColors.primaryColor,),)  : Icon(Icons.search, color: Theme.of(context).iconTheme.color,)
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    flex: 1,
                    child: TouchableOpacity(
                      onTap: (){
                        setSearchLoader();

                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:Icon(Icons.tune_outlined, color: Colors.white,),
                      ),
                    ),
                  )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: _recentJob.map((e) => _recentJobCard(e.image, e.title, e.description)).toList(),
              ),
            )
          ],
        ),
        )
        ),
    );
  }

    Widget _recentJobCard(String image, String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffFFBB0A).withOpacity(0.07)
      ),
      child: Row(
        children: [
          Image(image: AssetImage(image), width: 60, height: 60,),
          const Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSemiBold(title, fontSize: 14,fontWeight: FontWeight.w600, style: Theme.of(context).textTheme.bodyLarge,),
              TextSemiBold(description, style: Theme.of(context).textTheme.bodySmall,)
            ],
          )
        ],
      ),
    );
  }
}