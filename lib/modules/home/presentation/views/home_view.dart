import 'dart:math';

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/job_analytics_card.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
// ignore: library_prefixes
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/reconmende_job.entity.dart' as REconmendedJobs;
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/single_job.screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key,});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _search = TextEditingController();

  bool _isLoading = false;

  void setSearchLoader(){
    setState(() {
      _isLoading = true;
    });
    FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
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
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserViewModel>();
    final name = Functions.capitalize(user.authState.user?.firstName ?? "");
    final splitName = name.split(' ');
    final firstName = splitName[0];
    bool isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
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
          'Hi, ${firstName}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 16,
            fontFamily: AppFonts.manRope,fontWeight: FontWeight.w600
          )
        ),
        centerTitle: false,
        actions: const [
         NotificationIcon()
        ],
      ),
      body: SingleChildScrollView(
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
                            fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.08) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.08) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.1) : const Color(0xffFFFFFF).withOpacity(0.4)
                        ),
                        hintText: "Search",
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
                        child:
                        Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                            child:Image.asset("assets/icons/Settings-adjust.png", width: 30, height: 30,))
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: JobAnalyticsCard(),
            ),
            Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: TextSemiBold("Recommended", fontSize: 16, fontWeight: FontWeight.w600,),
            ),
            const Gap(8),
            Consumer<JobProvider>(
              builder: (context, reconmended, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xffDDA000).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextSemiBold(reconmended.reconmendedjobs.firstOrNull?.title.toString() ?? "", fontWeight: FontWeight.w700, color: isLight ? AppColors.background : AppColors.white,),
                            Gap(8),
                            TextSemiBold("${reconmended.reconmendedjobs.length ?? 0} Available Jobs", color: Color(0xff909090),)
                          ],
                        ),
                        Row(
                          children: [
                            TextSemiBold("View Jobs", color: AppColors.primaryColor,),
                            Gap(5),
                            Icon(Icons.north_east_outlined, color: AppColors.primaryColor,)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: TextSemiBold("Job Match Your Skills", fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
            ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             child: Consumer<JobProvider>(
                builder: (context, job, child) {
                return  job.job.isEmpty && job.jobhState.isGenerating ? const Center(child: CircularProgressIndicator()) : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),

                  shrinkWrap: true,
                  itemCount: job.job.length >= 3 ? 3 : job.job.length,
                  itemBuilder:(context, index) {
                    final e = job.job[index];
                    // logger.d(e);
                    return _recentJobCard(e);
                  }
               );
                }
              ),
           ),
          ],
        ),
      ),
    );
  }

   Widget _recentJobCard(Datum data) {
     logger.d(data.description!.length);
   final image = data.hiringOrganization;
   final desc = Text(data.description.toString(), maxLines: 1,);
    return TouchableOpacity(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => SingleJobScreen(data: data),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color(0xffEBEBEB),
          )
        ),
        child: Column(
          children: [
            ListTile(

              contentPadding: EdgeInsets.zero,
              leading: image == null ? SvgPicture.asset("assets/icons/company_placeholder.svg",) : image.logo == null ?  SvgPicture.asset("assets/icons/company_placeholder.svg") :
               Hero(
                 tag: image.logo!,
                 child: CachedNetworkImage(
                  imageUrl: image.logo!,
                  placeholder: (context, url) => const SizedBox(width: 30, height:30, child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
                               ),
               ),
              title: TextSemiBold(data.title.toString(), fontSize: 14,fontWeight: FontWeight.w600,), subtitle: TextSemiBold(data.hiringOrganization?.name.toString() ?? "Unknown Company", fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,),),
            SizedBox(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  chip(data.employmentType),
                  Gap(5),
                  chip(data.jobLocationType),
                  // Gap(5),
                  // chip(data.employmentType),
                ],
              ),
            ),

            Gap(20),

        HtmlWidget(
          enableCaching: true,
           data.description == null ? "" : data.description!.length < 90 ? data.description.toString() : '${data.description!.substring(0, 90)}..',
          textStyle: const TextStyle(fontSize: 12, color: Color(0xff7B7B7B), fontFamily: AppFonts.manRope, ),
        ),

          ],
        ),
      ),
    );
  }
  
  Widget chip(text){
    bool isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
        color: isLight ?  Color(0xffFDF9EE) : AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLight ? Colors.transparent : Color(0xffFDF9EE)
        )
      ),
      child: Center(child: TextSemiBold(text, fontSize: 12,)),
    );
  }
}
