// ignore_for_file: use_build_context_synchronously

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/shimmer-loading-list.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/job_analytics_card.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/single_job.screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _search = TextEditingController();

  bool _isLoading = false;

  void setSearchLoader() async {
    setState(() {
      _isLoading = true;
    });
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }

    await context
        .read<JobProvider>()
        .getSearchJobs(context, _search.text.trim());
    setState(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _search.clear();
        });
      }
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
    final name = Functions.capitalize(
        user.authState.user?.user?.userProfile?.firstName ?? "");
    final splitName = name.split(' ');
    final firstName = splitName[0];
    bool isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: TouchableOpacity(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: const Icon(Icons.menu)),
        ),
        title: Text('Hi, $firstName',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 16,
                fontFamily: AppFonts.manRope,
                fontWeight: FontWeight.w600)),
        centerTitle: false,
        actions: const [NotificationIcon()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<UserViewModel>().fetchUser(context);
          await context.read<JobProvider>().getJobs(context);
          await context.read<JobProvider>().get_reconmended_jobs(context);
        },
        backgroundColor: AppColors.primaryColor,
        color: Colors.white,
        strokeWidth: 3,
        displacement: 50,
        edgeOffset: 20,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: _search,
                          decoration: textInputDecoration.copyWith(
                            fillColor:
                                Theme.of(context).colorScheme.brightness ==
                                        Brightness.light
                                    ? AppColors.white
                                    : AppColors.background,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                                .colorScheme
                                                .brightness ==
                                            Brightness.light
                                        ? const Color(0xff000000)
                                            .withOpacity(0.08)
                                        : const Color(0xffFFFFFF)
                                            .withOpacity(0.18))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                                .colorScheme
                                                .brightness ==
                                            Brightness.light
                                        ? const Color(0xff000000)
                                            .withOpacity(0.08)
                                        : const Color(0xffFFFFFF)
                                            .withOpacity(0.18))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                            .colorScheme
                                            .brightness ==
                                        Brightness.light
                                    ? const Color(0xff000000).withOpacity(0.1)
                                    : const Color(0xffFFFFFF).withOpacity(0.4)),
                            hintText: "Search",
                            prefixIcon: _isLoading
                                ? Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 5),
                                    height: screenHeight(context) * 0.05,
                                    width: screenWidth(context) * 0.05,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : Icon(
                                    Icons.search,
                                    size: 20,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TouchableOpacity(
                        onTap: () {
                          setSearchLoader();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.search, color: Colors.white)
                              // Image.asset(
                              //   "assets/icons/Settings-adjust.png",
                              //   width: 30,
                              //   height: 30,
                              // ),
                              ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(20),
              //TODO: IMPLEMENT ANALYTICS API AND DISPLAY CARD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: JobAnalyticsCard(),
              ),
              Gap(30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                child: TextSemiBold(
                  "Recommended",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(8),
              Consumer<JobProvider>(builder: (context, reconmended, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xffDDA000).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded to handle overflow on the left side
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title with ellipsis in case of overflow
                              TextSemiBold(
                                reconmended.reconmendedjobs.firstOrNull?.title
                                        .toString() ??
                                    "No Jobs yet!",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1, // Limit to 1 line
                                fontWeight: FontWeight.w700,
                                color: isLight
                                    ? AppColors.background
                                    : AppColors.white,
                              ),
                              Gap(8),
                              // Available Jobs text
                              TextSemiBold(
                                "${reconmended.reconmendedjobs.length} Available Jobs",
                                color: Color(0xff909090),
                              ),
                            ],
                          ),
                        ),
                        // View Jobs button and icon
                        Row(
                          children: [
                            TouchableOpacity(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeNavigation(
                                            selectedIndex: 1, fromHome: true),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: TextSemiBold(
                                "View Jobs",
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Gap(5),
                            Icon(
                              Icons.north_east_outlined,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const Gap(30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: TextSemiBold(
                  "Job Match Your Skills",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? AppColors.background
                      : AppColors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Consumer<JobProvider>(builder: (context, job, child) {
                  return Builder(builder: (context) {
                    if (job.jobhState.isGenerating) {
                      return ShimmerLoadingList();
                    } else if (job.job.isEmpty) {
                      return Container(
                          margin: EdgeInsets.only(top: size.height * 0.1),
                          child: Center(child: _noJobCard(context)));
                    } else {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: job.job.length >= 3 ? 3 : job.job.length,
                          itemBuilder: (context, index) {
                            final e = job.job[index];
                            // logger.d(e);
                            return _recentJobCard(e);
                          });
                    }
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentJobCard(Datum data) {
    logger.d(data.description!.length);
    logger.d(data.description);
    final image = data.hiringOrganization;
    logger.d(image?.logo);
    // final desc = Text(
    //   data.description.toString(),
    //   maxLines: 1,
    // );
    return TouchableOpacity(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SingleJobScreen(data: data),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
            )),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                width: 50.w,
                height: 40.h,
                child: image == null
                    ? SvgPicture.asset(
                        "assets/icons/company_placeholder.svg",
                      )
                    : image.logo == null
                        ? SvgPicture.asset(
                            "assets/icons/company_placeholder.svg")
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                              imageUrl: image.logo!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const SizedBox(
                                  width: 30,
                                  height: 30,
                                
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  SvgPicture.asset(
                                "assets/icons/company_placeholder.svg",
                                width: 40.w,
                                height: 40.h,
                              ),
                              
                            ),
                        ),
              ),
              title: TextSemiBold(
                data.title.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              subtitle: TextSemiBold(
                data.hiringOrganization?.name.toString() ?? "Unknown Company",
                fontSize: 11,
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
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
              data.description == null
                  ? ""
                  : data.description!.length < 90
                      ? data.description.toString()
                      : '${data.description!.substring(0, 90)}..',
              textStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xff7B7B7B),
                fontFamily: AppFonts.manRope,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chip(text) {
    bool isLight = Theme.of(context).colorScheme.brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
          color: isLight ? Color(0xffFDF9EE) : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isLight ? Colors.transparent : Color(0xffFDF9EE))),
      child: Center(
          child: TextSemiBold(
        text ?? "",
        fontSize: 12,
      )),
    );
  }

  Widget _noJobCard(BuildContext context) {
    return Column(
      children: [
        const Gap(40),
        SvgPicture.asset(
          "assets/images/Frame 482398.svg",
        ),
        const Gap(20),
        TextBold(
          "No job available",
          color: Theme.of(context).colorScheme.brightness == Brightness.light
              ? AppColors.background.withValues(alpha: 0.8)
              : AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
