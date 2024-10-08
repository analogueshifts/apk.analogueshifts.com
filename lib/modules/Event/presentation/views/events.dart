

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/change_notifier/event.notifier.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/views/create_event.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/views/single-event.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/event_card.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/shimmer-loading-list.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/social_event_card.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/onboarding/presentation/views/illustrator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {


  int _currentIndex = 0;

  // Future<void> _refreshData() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async{
  //
  //   });
  // }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventProvider>().getUpcomingEvents(context);
      context.read<EventProvider>().getSavedEvents(context);
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isLight = Theme.of(context).brightness == Brightness.light;
    bool _isLoading = false;
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
        title: TextBold("Events", fontSize: 20, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
        centerTitle: true,
        actions: const [
          NotificationIcon()
        ],
      ),
      body: Consumer<EventProvider>(
        builder: (_, event, __) =>
        RefreshIndicator(
          onRefresh: () async{
            await context.read<EventProvider>().getUpcomingEvents(context);
            await context.read<EventProvider>().getSavedEvents(context);
          },
          backgroundColor: AppColors.primaryColor,
          color: Colors.white,
          strokeWidth: 3,
          displacement: 50,
          edgeOffset: 20,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                TextFormField(
                  // controller: _search,
                  decoration: textInputDecoration.copyWith(
                      fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffD2D2D2) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                      ),
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffD2D2D2) : const Color(0xffFFFFFF).withOpacity(0.3)
                      ),
                      hintText: "Search for events",
                      // ignore: dead_code
                      prefixIcon: _isLoading ? Container(margin: const EdgeInsets.only(left:
                      5), height: screenHeight(context) * 0.01, width: screenWidth(context) * 0.01, child: const CircularProgressIndicator(color: AppColors.primaryColor,),)  : Icon(Icons.search, color: Theme.of(context).iconTheme.color,)
                  ),
                ),
                Gap(30),
                TextBold(event.upcomingEvents.isEmpty ? "" : "Upcoming Evennts",
                  color:Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                Gap(8),
                // event.upcomingEvents.isEmpty ? Text("") :
                 SizedBox(
                   height: 250.w,
                   child: PageView(
                     onPageChanged: (value){
                       setState(() {
                         _currentIndex = value;
                       });
                     },
                     children: event.upcomingEvents.map((e) =>
                         SocialPostWidget(
                           locationType: e.locationType ?? "",
                           location: e.location ?? null,
                           title: e.title ?? "",
                           userImageUrl: e.thumbnail.toString() ?? "",
                           backgroundImageUrl: e.thumbnail.toString() ?? "",
                         ),
                   ).toList()
          
                   ),
                 ),
                Gap(15),
                IllustrationIndicator(activeCard: _currentIndex, length: event.upcomingEvents.length,),
                const Gap(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBold("All Events",
                        color:Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,
                       fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => CreateEventStepForm(),
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
                      child: Row(
                        children: [
                          const Icon(Icons.add, color: AppColors.primaryColor,),
                          TextSemiBold("Create Events", color: AppColors.primaryColor, fontWeight: FontWeight.w500,)
                        ],
                      ),
                    )
                  ],
                ),
                Gap(10),
                event.events.isEmpty && event.eventState.isGenerating  ?
                ShimmerLoadingList() :
                    event.events.isEmpty ?
                    _noEventCard(context) :
                Column(
                  children: [
                    // const Gap(10),
                    Column(
                      children:
                      event.events.map((e) =>
                          ListTile(
                            onTap: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => SingleEvent(data: e),
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
                            contentPadding: EdgeInsets.zero,
                            leading:  e.thumbnail == null ? SvgPicture.asset("assets/images/calendar.svg", width: 40.w, height: 40.h,):
                            CircleAvatar(
                              radius: 30.w,
                              child: ClipOval(
                                child: Hero(
                                  tag: e.thumbnail!,
                                  child: CachedNetworkImage(
                                    imageUrl: e.thumbnail ?? "",
                                    width: 40.w,
                                    height: 40.h,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => CircleAvatar(
                                        backgroundColor: Theme.of(context).colorScheme.background,
                                        minRadius: 40,
                                        child: const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Icon(Icons.error, size: 50,),
                                  ),
                                ),
                              ),
                            ),
                            title: TextSemiBold(e.title.toString()),
                            subtitle: TextSemiBold(e.locationType != "online" ? e.location.toString() : "Online Meeting", color: _isLight ? Color(0xff000000).withOpacity(0.36) : AppColors.grey,),
                            trailing: Icon(Icons.keyboard_arrow_right_outlined, size: 30, color: _isLight ? AppColors.background : AppColors.white, ),
                          )
                      ).toList()
                    ),
                  ],
                )
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Widget buildIndicator(int index) {
//   return Container(
//     width: 8,
//     height: 8,
//     margin: EdgeInsets.symmetric(horizontal: 4),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: _currentPage == index ? Colors.blue : Colors.grey,
//     ),
//   );
// }

Widget _noEventCard(BuildContext context){
  return Column(
    children: [
      const Gap(40),
      SvgPicture.asset("assets/images/Frame 482398.svg"),
      const Gap(20),
      TextBold("No events created",
        color:Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,
        fontSize: 19,
        fontWeight: FontWeight.w600,
      ),
      const Gap(10),
      TextSemiBold(
        "Click the button at the bottom/above to create an event.",
        color: const Color(0xff666666),
        textAlign: TextAlign.center,
      ),
      const Gap(35),
      BusyButton(title: "Create Event", onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateEventStepForm()),
        );
      })
    ],
  );

}
