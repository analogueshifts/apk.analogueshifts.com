import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/authenticate_view.dart';
import 'package:analogue_shifts_mobile/modules/onboarding/presentation/views/illustrator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  bool _isAnimated = false;

  void _handleTap() {
    setState(() {
      _isAnimated = true;
    });
    // Reset the animation after 5 seconds
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isAnimated = false;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: Container(
              // height: screenHeight(context) * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                color: currentIndex == 0 ? AppColors.secondaryYellow.withOpacity(0.33) : currentIndex == 1 ? Color(0xff690A3F).withOpacity(0.11) : Color(0xffB73F39).withOpacity(0.18),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      // alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: currentIndex < 1 ? false : true,
                            child: InkWell(
                              onTap: () {
                                if (currentIndex == 0) {
                                } else {
                                  _pageController.previousPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.linearToEaseOut,
                                  );
                                }
                              },
                              child: Icon(Icons.keyboard_arrow_left_outlined)
                            ),
                          ),
                          Visibility(
                            visible: currentIndex > 1 ? false : true,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => Authenticate()),
                                        (Route<dynamic> route) => true);
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  color: AppColors.primaryGrey.withOpacity(0.33),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.manRope,
                                ),
                              ).animate().slide(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      // width: double.infinity,
                      height: screenHeight(context) * 0.4,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: (int index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        children: [
                          Image.asset(AppAsset.onboard1),
                          Image.asset(AppAsset.onboard2),
                          Image.asset(AppAsset.onboard3),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                IllustrationIndicator(
                  activeCard: currentIndex,
                ),
                // Gap(30),
                // const SizedBox(height: 16),
                AnimatedContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  duration: const Duration(milliseconds: 300),
                  child: currentIndex == 0
                      ? Column(
                    children: [
                      FittedBox(
                        child: Text(
                          'Welcome!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.background,
                            fontSize: 26.0,
                            fontFamily: AppFonts.manRope,
                            height: 1.2,
                          ),
                        ).animate().slideY(),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Tristique ullamcorper lacus risus ac dui sed at ac sed. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimaryColor2,
                          fontSize: 14,
                          fontFamily: AppFonts.manRope,
                          height: 1.44,
                        ),
                      ).animate().slideY()
                    ],
                  )
                      : currentIndex == 1
                      ? Column(
                    children: [
                      FittedBox(
                        child: Text(
                          'Search for jobs!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.background,
                            fontSize: 26.0,
                            fontFamily: AppFonts.manRope,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Tristique ullamcorper lacus risus ac dui sed at ac sed. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimaryColor2,
                          fontSize: 14,
                          fontFamily: AppFonts.manRope,
                          height: 1.44,
                        ),
                      )
                    ],
                  )
                      : Column(
                    children: [
                      FittedBox(
                        child: Text(
                          'Ready to find a job?',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.background,
                            fontSize: 26.0,
                            fontFamily: AppFonts.manRope,
                            height: 1.2,
                          ),
                        ).animate().slideY(),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Tristique ullamcorper lacus risus ac dui sed at ac sed. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimaryColor2,
                          fontSize: 14,
                          fontFamily: AppFonts.manRope,
                          height: 1.44,
                        ),
                      ).animate().slideY()
                    ],
                  ),
                ),
                // const SizedBox(height: 50),
                //   Gap(50),
                GestureDetector(
                  onTap: () {
                    _handleTap();
                    if (currentIndex == 2) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Authenticate()),
                              (Route<dynamic> route) => true);
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeOutCirc,
                      );
                    }
                  },
                  child:currentIndex == 2 ?  Container(
                    width: screenWidth(context) * 0.5,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: currentIndex != 2 ? Icon(Icons.arrow_forward_outlined, color: Colors.white,) : Text(
                        currentIndex == 2 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryColor,
                          fontFamily: AppFonts.manRope,
                        ),
                      ), 
                    ),
                  ) : AnimatedContainer(
                    width: 70,
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    decoration: BoxDecoration(
                      color: _isAnimated ? Colors.blue : AppColors.primaryColor,
                      // color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    duration: Duration(seconds: 1),


                    child: Center(
                      child: currentIndex != 2 ? Icon(Icons.arrow_forward_outlined, color: Colors.white,size: 30,) : Text(
                        currentIndex == 2 ? 'Proceed' : 'Next',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryColor,
                          fontFamily: AppFonts.manRope,
                        ),
                      ),
                    ),
                  ),
                )
              ],),
            ),
          )


        ],
      ),
    );
  }
}