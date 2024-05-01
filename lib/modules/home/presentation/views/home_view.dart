import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/home/data/model/job_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key,});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<JobPost> _jobpost = [
    JobPost(image: "assets/images/jobPost1.png", text: "\$50 - \$75/hr", title: "Software Engineer"),
    JobPost(image: "assets/images/jobPost1.png", text: "\$40 - \$65/hr", title: "Software Designer"),
    JobPost(image: "assets/images/jobPost1.png", text: "\$50 - \$75/hr", title: "Software Engineer"),
  ];

  final List<RecentJob> _recentJob = [
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
      
      appBar: AppBar(
        elevation: 0,
        leading: TouchableOpacity(
          onTap: () {
             Scaffold.of(context).openDrawer();
          },
          child: Container(
              width: 20, height: 20,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: const Icon(Icons.menu)
          ),
        ),
        title: Text(
          "Hi, John",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 16
          )
        ),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () => context.goNamed('notification'),
            child: Padding(
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
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _search,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Search',
                          prefixIcon: _isLoading ? Container(margin: const EdgeInsets.only(left:
                          5), height: screenHeight(context) * 0.01, width: screenWidth(context) * 0.01, child: const CircularProgressIndicator(color: AppColors.primaryColor,),)  : Icon(Icons.search, color: Theme.of(context).iconTheme.color,)
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
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
                        child:const Icon(Icons.tune_outlined, color: Colors.white,),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: TextSemiBold("Reconmended", fontSize: 20, fontWeight: FontWeight.w700,),
            ),
            const Gap(8),
            SizedBox(
              height: 160.h,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _jobpost.length,
                  itemBuilder:(context, index){
                  final data = _jobpost[index];
                    return _jobCard(data.image, data.title, data.text);
                  }
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: TextSemiBold("Recently Posted", fontSize: 20, fontWeight: FontWeight.w700, style: Theme.of(context).textTheme.titleLarge,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: _recentJob.map((e) => _recentJobCard(e.image, e.title, e.description)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _jobCard(String image, String title, String text){
    return Container(
      height: 160.h,
      width: 170.w,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   color: const Color(0xffFFBB0A).withOpacity(0.07)
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150.w,
            height: 80.h,
            child: Image(image:AssetImage(image), fit: BoxFit.fill,)),
          const Gap(15),
          TextBold(title, fontSize: 14, style: Theme.of(context).textTheme.bodyMedium,),
          const Gap(8),
          TextSemiBold(text, fontSize: 11, color: AppColors.grey,)
        ],
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
