import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/home/data/model/job_model.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class JobView extends StatefulWidget {
  const JobView({super.key});

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(mounted){
        context.read<JobProvider>().getJobs(context);
      }


    });
    super.initState();

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
        leading: Container(

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
      body: Consumer<JobProvider>(
        builder: (context, job, child) {
          return job.jobhState.isGenerating ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(
            color: Colors.white,
            backgroundColor: AppColors.primaryColor,
            onRefresh: () => job.getJobs(context), // Your refresh logic
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                prefixIcon: _isLoading ? Container(margin: const EdgeInsets.only(left:
                                5), height: screenHeight(context) * 0.01, width: screenWidth(context) * 0.01, child: const CircularProgressIndicator(color: AppColors.primaryColor,),)  : const Icon(Icons.search)
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
                            child:const Icon(Icons.tune_outlined, color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(30),
                  job == null ? Center(
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
                        logger.d(e);
                        return _recentJobCard(e.hiringOrganization?.logo ?? "", e.title ?? "", e.hiringOrganization?.name ?? "");
                        // return _recentJobCard(jobData.hiringOrganization?.logo, jobData.title.toString(), jobData.hiringOrganization?.name.toString() ?? "");
                      }
                  ),
                  // job == null ? CircularProgressIndicator() :
                  // Column(
                  //   children: job.job.map((e) => _recentJobCard(e.hiringOrganization?.logo ?? "", e.title ?? "", e.hiringOrganization?.name ?? "")).toList(),
                  // )
                ],
              ),
            ),
          );
          // return TextSemiBold("No Jobs available");
        },
      ),
    );
  }

  Widget _recentJobCard(String image, String title, String organization) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffFFBB0A).withOpacity(0.07)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) => const SizedBox(width: 30, height:30, child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        title: TextSemiBold(title, fontSize: 14,fontWeight: FontWeight.w600,), subtitle: TextSemiBold(organization, fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,),),
    );
  }
}
