import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/home/data/model/job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class JobView extends StatefulWidget {
  const JobView({super.key});

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {


  final List<RecentJob> _recentJob = [
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
    RecentJob(image: "assets/images/youtube.png", title: "Mid-level Security Analyst", description: "Youtube"),
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
      backgroundColor: AppColors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        leading: Container(
          width: 20, height: 20,
          margin: const EdgeInsets.only(left: 8.0),
          child: Image.asset("assets/images/Avatar Image.png",),
        ),
        title: TextBold("Jobs", fontSize: 20,),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(AppAsset.notificationIicon),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            Row(
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
            Gap(30),
            Column(
              children: _recentJob.map((e) => _recentJobCard(e.image, e.title, e.description)).toList(),
            )
          ],
        ),
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
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image(image: AssetImage(image), width: 60, height: 60,), title: TextSemiBold(title, fontSize: 14,fontWeight: FontWeight.w600,), subtitle: TextSemiBold(description, fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,),),
    );
  }
}
