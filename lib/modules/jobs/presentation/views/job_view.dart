import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/shimmer-loading-list.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/post_job.screen.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/single_job.screen.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/widgets/jobListing_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';


class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  bool showMyPlans = true;

  bool _isLoading = false;

  final TextEditingController _search = TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: TextBold("Jobs", fontSize: 20, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
        centerTitle: true,
        actions: [
          const NotificationIcon()
        ],
      ),
      body: Column(
        children: [
          const Gap(15),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light ? const Color(0xffFFFAEB) : AppColors.background
            ),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showMyPlans = !showMyPlans;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      decoration: BoxDecoration(
                          color: showMyPlans
                              ? const Color(0xffFFBB0A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 15),
                      child: TextSemiBold('Apply to Jobs', textAlign: TextAlign.center, color: showMyPlans ? AppColors.white : const Color(0xffFFBB0A),),
                    ),
                  ),
                ),
                Expanded(
                    child:InkWell(
                      onTap: () {
                        setState(() {
                          showMyPlans = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.fastEaseInToSlowEaseOut,
                        decoration: BoxDecoration(
                            color: !showMyPlans
                                ? const Color(0xffFFBB0A)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 15),
                        child: TextSemiBold('Post a Jobs', textAlign: TextAlign.center, color: !showMyPlans ? AppColors.white : const Color(0xffFFBB0A)),
                      ),
                    ),

                )

              ],

              // isSelected: [!showMyPlans, showMyPlans],
            ),
          ),
          Expanded(
              child: showMyPlans
                  ? const JobView()
                  : const PostJobScreen()
          ),
        ],
      ),
    );
  }
}


class JobView extends StatefulWidget {
  const JobView({super.key});

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {

  final TextEditingController _search = TextEditingController();

  bool _isLoading = false;

  final _scrollController = ScrollController();
  bool _isPaginateButton = false;

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JobProvider>().getJobs(context);
    });
    _scrollController.addListener(_onScroll);
    super.initState();
  }


  @override
  void dispose() {
    _search.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      final jobmodel = context.read<JobProvider>();
      if (jobmodel.lastPage != jobmodel.currentPage) {
        setState(() {
          _isPaginateButton = true;
        });
        // context.read<JobProvider>().getJobs(context, context.read<JobProvider>().currentPage + 1);
      }
    }else{
       setState(() {
          _isPaginateButton = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JobProvider>(
        builder: (context, job, child) {
          return job.jobhState.isGenerating & job.job.isEmpty  ?
          Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ShimmerLoadingList(),
          ))
              :
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Gap(17),
                Row(
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
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                                child:Image.asset("assets/icons/Settings-adjust.png", width: 30, height: 30,))
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(30),
                Row(
                  children: [
                    TextSemiBold("All Jobs", fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white, textAlign: TextAlign.start,),
                  ],
                ),
                const Gap(5),
                job.job.isEmpty
                    ? Center(
                  child: Column(
                    children: [
                      TextSemiBold("No job available")
                    ],
                  ),
                ) :
                 ListView.builder(
                  
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: job.job.length,
                    itemBuilder:(context, index) {
                      final e = job.job[index];
                      // logger.d(e);
                      return Column(
                        children: [
                          _recentJobCard(e),
                          const Gap(10),
                          Divider(color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffE4E4E4) : const Color(0xffFFFFF).withOpacity(0.24),)
                        ],
                      );
                    }
                ),
                const Gap(20),
                _isPaginateButton ?
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: (){
                        final updateCurrentPage = job.currentPage + 1;
                        job.getJobs(context, updateCurrentPage);
                    },
                    child: job.job.isNotEmpty && job.jobhState.isGenerating ? Center(child: CircularProgressIndicator()) : TextSemiBold("View All Jobs", color: AppColors.primaryColor, fontWeight: FontWeight.w700,) ,
                  ),
                )
                    :
                const Text(""),
              ],
            ),
          );
          // return TextSemiBold("No Jobs available");
        },
      ),
    );
  }

  Widget _recentJobCard(Datum data) {
    final image = data.hiringOrganization;
    final desc = Text(data.description.toString(), maxLines: 1,);
    return TouchableOpacity(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleJobScreen(data: data)
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xffEBEBEB),
            )
        ),
        child: Column(
          children: [
            ListTile(

              contentPadding: EdgeInsets.zero,
              leading: image == null ? SvgPicture.asset("assets/icons/company_placeholder.svg",) : image.logo == null ?  SvgPicture.asset("assets/icons/company_placeholder.svg") :
              CachedNetworkImage(
                imageUrl: image.logo!,
                placeholder: (context, url) => const SizedBox(width: 30, height:30, child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
              ),
              title: TextSemiBold(data.title.toString(), fontSize: 14,fontWeight: FontWeight.w600,), subtitle: TextSemiBold(data.hiringOrganization?.name.toString() ?? "Unknown Company", fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,),),
            SizedBox(
              height: 32.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  chip(data.employmentType),
                  const Gap(5),
                  chip(data.jobLocationType),
                  // Gap(5),
                  // chip(data.employmentType),
                ],
              ),
            ),

            const Gap(20),

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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: isLight ?  const Color(0xffFDF9EE) : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isLight ? Colors.transparent : const Color(0xffFDF9EE)
          )
      ),
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          TextSemiBold(text, fontSize: 12,),
        ],
      )),
    );
  }
}
