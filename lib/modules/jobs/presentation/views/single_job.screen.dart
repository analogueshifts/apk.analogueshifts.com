import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/custom_single_chile_scroll_view.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SingleJobScreen extends StatefulWidget {
final Datum data;
  const SingleJobScreen({super.key, required this.data});

  @override
  State<SingleJobScreen> createState() => _SingleJobScreenState();
}

class _SingleJobScreenState extends State<SingleJobScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.brightness;
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Job Details"),
      body: CustomSingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                   widget.data.hiringOrganization == null ? SvgPicture.asset("assets/images/work-image.svg") : widget.data.hiringOrganization?.logo == null ?  SvgPicture.asset("assets/images/work-image.svg") :
                  CachedNetworkImage(
                    imageUrl: "",
                    width: 50.w,
                    height: 50.h,
                    placeholder: (context, url) => const SizedBox(width: 30, height:30, child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
                  ),
                  Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSemiBold(widget.data.title.toString(), fontSize: 14,fontWeight: FontWeight.w600,),
                      TextSemiBold(widget.data.hiringOrganization?.name.toString() ?? "Unknown Company", fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,),
                    ],
                  )
                ],
              ),
              Gap(15),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Color(0xff7B7B7B),),
                  Gap(6),
                  TextSemiBold(widget.data.jobLocation?.address == null ? "N/A" : widget.data.jobLocation?.address?.addressRegion == null && widget.data.jobLocation?.address?.addressCountry == null ? "N/A" : "${widget.data.jobLocation?.address?.addressRegion}, ${widget.data.jobLocation?.address?.addressCountry}",  fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff7B7B7B),),
                ],
              ),
              Gap(7),
              Row(
                children: [
                  Icon(Icons.work_outline_outlined, color: Color(0xff7B7B7B),),
                  Gap(6),
                  Text(widget.data.baseSalary == null ? "N/A" : widget.data.baseSalary?.value == null && widget.data.baseSalary?.value?.value == null ? "N/A" : Functions.money(double.parse("${widget.data.baseSalary?.value?.value.toString() ?? "0"}"), '\$'),  style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff7B7B7B),
                  ),),
                ],
              ),
              Text(widget.data.toString()),
              Gap(15),
              Spacer(),
              BusyButton(title: "Apply", onTap:() {
                
              },),
              Gap(20)
            ],
          ),
        ),
      ),
    );
  }
}