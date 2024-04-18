import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/home/data/model/job_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

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
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
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
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        // backgroundColor: Colors.white,
        leading: Container(
            width: 20, height: 20,
          margin: const EdgeInsets.only(left: 8.0),
          child: Image.asset("assets/images/Avatar Image.png",),
        ),
        title: TextBold("Hi, John", fontSize: 20,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(AppAsset.notificationIicon),
          )
        ],
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          5), height: screenHeight(context) * 0.01, width: screenWidth(context) * 0.01, child: CircularProgressIndicator(color: AppColors.primaryColor,),)  : Icon(Icons.search)
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
            Gap(30),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: TextSemiBold("Reconmended", fontSize: 20, fontWeight: FontWeight.w700,),
            ),
            Gap(10),
            SizedBox(
              height: screenHeight(context) * 0.25,

              child: ListView.builder(
                padding: EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _jobpost.length,
                  itemBuilder:(context, index){
                  final data = _jobpost[index];
                    return _jobCard(data.image, data.title, data.text);
                  }
              ),
            ),
            Gap(50),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: TextSemiBold("Recently Posted", fontSize: 20, fontWeight: FontWeight.w700,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffFFBB0A).withOpacity(0.07)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image:AssetImage(image), height: screenHeight(context) * 0.13,),
          Gap(15),
          TextBold(title, fontSize: 14,),
          Gap(8),
          TextSemiBold(text, fontSize: 11, color: AppColors.grey,)
        ],
      ),
    );
  }

  Widget _recentJobCard(String image, String title, String description) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffFFBB0A).withOpacity(0.07)
      ),
      child: Row(
        children: [
          Image(image: AssetImage(image), width: 60, height: 60,),
          Gap(6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSemiBold(title, fontSize: 14,fontWeight: FontWeight.w600,),
              TextSemiBold(description, fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,)
            ],
          )
        ],
      ),
    );
  }
}
