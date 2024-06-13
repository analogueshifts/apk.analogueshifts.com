import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/jobs/domain/entities/jobs_response.entity.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/single_job.screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      body: Consumer<JobProvider>(
        builder: (context, job, child) {
          return job.jobhState.isGenerating ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
            controller: _scrollController,
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
                            fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                          )
                        ),
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.4)
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
                          child:const Icon(Icons.tune_outlined, color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(30),
                job.job.isEmpty ? Center(
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
                _isPaginateButton ? BusyButton(title: "Load More...", onTap:() {
                  final updateCurrentPage = job.currentPage + 1;
                  job.getJobs(context, updateCurrentPage);
                },) : const Text("")
              ],
            ),
          );
          // return TextSemiBold("No Jobs available");
        },
      ),
    );
  }

  Widget _recentJobCard(Datum data) {
   final image = data.hiringOrganization == null ? null : data.hiringOrganization;
    // logger.d(data.hiringOrganization?.logo);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: ListTile(
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleJobScreen(data: data)
          ),
        );
        },
        contentPadding: EdgeInsets.zero,
        leading: image == null ? SvgPicture.asset("assets/images/work-image.svg") : image.logo == null ?  SvgPicture.asset("assets/images/work-image.svg") :
         CachedNetworkImage(
          imageUrl: "",
          placeholder: (context, url) => const SizedBox(width: 30, height:30, child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
        ),
        title: TextSemiBold(data.title.toString(), fontSize: 14,fontWeight: FontWeight.w600,), subtitle: TextSemiBold(data.hiringOrganization?.name.toString() ?? "Unknown Company", fontSize: 11,color: AppColors.grey, fontWeight: FontWeight.w400,),),
    );
  }
}
