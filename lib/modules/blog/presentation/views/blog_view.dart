import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(
        ),
        title: TextBold("Blogs", fontSize: 20,),
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
                        // controller: _search,
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
                        // setSearchLoader();

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
            Gap(20),
            _jobCard(),
            Gap(20),
            _jobCard()
          ],
        ),
      ),
    );
  }


  Widget _jobCard(){
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: double.infinity,
        // height: 170,
        decoration: BoxDecoration(
          color: Color(0xffFFFAEE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage("assets/images/IMG6 2.png")),
            Gap(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextSemiBold("Tech", color: AppColors.grey,),
                Gap(30),
                TextSemiBold("High Paying Jobs", color: AppColors.grey,)
              ],
            ),
            Gap(15),
            TextSemiBold("Unveiling the Top Programming Languages for 2024: A Closer Look at the Future of Coding", fontWeight: FontWeight.w600,),
            Gap(15),
            TextSemiBold("Posted: 17/02/2024", color: AppColors.grey,)
          ],)

    );
  }
}
