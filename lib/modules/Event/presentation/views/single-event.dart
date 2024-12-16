
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/Event/domain/entities/event.entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SingleEvent extends StatefulWidget {
  final Event data;
  const SingleEvent({super.key, required this.data});

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  @override
  Widget build(BuildContext context) {
    final event = widget.data;
    final isLight = Theme.of(context).brightness == Brightness.light;
    String formattedDate = DateFormat('MMMM d, y, h:mm a').format(event.startsDate!);
    logger.d(formattedDate);
    return Scaffold(
      appBar: PaylonyAppBarTwo(title: "View Event", actions: [
        Center(
          child: TextSemiBold("Share", color: AppColors.primaryColor,),
        ),

        const Gap(20)
      ],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.data.thumbnail == null ? Image.asset("assets/images/Rectangle 18921 (1).png", fit: BoxFit.fill, width: double.infinity, height: 203.h,):
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: Hero(
                tag: event.thumbnail!,
                child: CachedNetworkImage(
                  imageUrl: widget.data.thumbnail ?? "",
                  width: double.infinity,
                  height: 203.h,
                
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      minRadius: 40,
                      child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 50,),
                ),
              ),
            ),
            const Gap(25),
            TextSemiBold(event.title.toString(), fontSize: 16, fontWeight: FontWeight.w700,),
            const Gap(10),
            TextSemiBold(event.description.toString(), fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xff575757),),
            const Gap(20),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined, size: 20, color: isLight ? const Color(0xff575757) : AppColors.white,),
                          TextSemiBold("Venue", fontSize: 13, fontWeight: FontWeight.w600, color: isLight ? const Color(0xff575757) : AppColors.white,)
                        ],
                      ),
                      const Gap(6),
                      TextSemiBold(event.location.toString(), fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xffA3A3A3),),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined, size: 20, color: isLight ? const Color(0xff575757) : AppColors.white,),
                          TextSemiBold("Date", fontSize: 13, fontWeight: FontWeight.w600, color: isLight ? const Color(0xff575757) : AppColors.white,)
                        ],
                      ),
                      const Gap(6),
                      TextSemiBold("${formattedDate}", fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xffA3A3A3),),
                    ],
                  ),
                )
              ],
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.payments_outlined, size: 20, color: isLight ? const Color(0xff575757) : AppColors.white,),
                    const Gap(5),
                    TextSemiBold("Price", fontSize: 13, fontWeight: FontWeight.w600, color: isLight ? const Color(0xff575757) : AppColors.white,)
                  ],
                ),
                const Gap(6),
                TextSemiBold(Functions.money(double.parse(event.price ?? "0"), "\$"), fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xffA3A3A3),),
              ],
            ),
            const Gap(50),
            BusyButton(
                title: "Copy Link",
                onTap: (){
                  logger.d(event.location);

            })
          ],
        ),
      ),
    );
  }
}
